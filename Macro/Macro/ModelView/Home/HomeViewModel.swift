//
//  HomeModelView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI
import Foundation

class HomeViewModel: ObservableObject {
    let cloud = CloudKitModel.shared
    var income: Float = 0.0
    var users: [User] = []
    var goals: [Goal] = []
    var spentsCards: [SpentsCard] = []
    
    init() {
        Task.init {
            await loadUser()
            await loadSpentsCards()
            await loadGoals()
        }
    }
    
    func loadUser() async {
        let records = try? await self.cloud.fetchSharedPrivatedRecords(recordType: User.getType(), predicate: nil)
        guard let records = records else { return }
        for record in records {
            guard let user = User(record: record) else { return }
            users.append(user)
            income += user.income
        }
    }
    
    func loadGoals() async {
        do {
            guard let goals = try await fecthGoals() else { return  }
            self.goals = goals
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func loadSpentsCards() async {
        guard let methodologySpent = getMethodologySpent() else { return }
        for ind in 0 ..< methodologySpent.namePercent.count {
            if let spentsCard = try? await getSpentsCard(methodologySpent: methodologySpent, index: ind) {
                spentsCards.append(spentsCard)
            }
        }
    }
    
    private func getSpentsCard(methodologySpent: MethodologySpent, index: Int) async throws -> SpentsCard? {
        do {
            guard let avalibleMoney = try await avalibleMoneyCategory(categoryPorcent: methodologySpent.valuesPercent[index]) else { return nil }
            let spentsCard = SpentsCard(id: index, valuesPercent: methodologySpent.valuesPercent[index], namePercent: methodologySpent.namePercent[index], avalibleMoney: avalibleMoney )
            return spentsCard
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func getMethodologySpent() -> MethodologySpent? {
        guard let user = users.first else { return nil }
        guard let methodologySpent = user.methodologySpent else { return nil }
        return methodologySpent
    }
    
    private func valuePorcentCategory(categoryPorcent: Int) -> Float {
        return income*(Float(categoryPorcent)/100)
    }
    
    private func avalibleMoneyCategory(categoryPorcent: Int) async throws -> Float? {
        var value: Float = 0.0
        let records = try? await cloud.fetchSharedPrivatedRecords(recordType: Spent.getType(), predicate: "categoryPercent == \(categoryPorcent)")
        guard let records = records else { return nil }
        for record in records {
            guard let spent = Spent(record: record) else { return nil }
            value += spent.value
        }
        let total = valuePorcentCategory(categoryPorcent: categoryPorcent)
        return  total - value
    }
    
    private func fecthGoals() async throws -> [Goal]? {
        var goals: [Goal] = []
        let records = try? await cloud.fetchSharedPrivatedRecords(recordType: Goal.getType(), predicate: nil)
        guard let records = records else { return nil }
        for record in records {
            guard let goal = Goal(record: record) else { return nil }
            goals.append(goal)
        }
        return goals
    }
    
}

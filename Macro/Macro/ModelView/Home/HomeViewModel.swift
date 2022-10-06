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
    @Published var users: [User] = []
    @Published var goals: [Goal] = []
    @Published var spentsCards: [SpentsCard] = []
    
    init() {
        Task.init {
            guard let users = await loadUser() else { return }
            DispatchQueue.main.async {
                self.users = users
                self.income = 0
                for user in users {
                    self.income += user.income
                }
            }
        }
        Task.init {
            guard let spentsCards = await loadSpentsCards() else { return }
            DispatchQueue.main.async {
                self.spentsCards = spentsCards
            }
        }
        Task.init {
            await loadGoals()
        }
    }
    
    func getUserName() -> String {
        let nameFamily = users.first?.name.replacingOccurrences(of: "givenName:", with: "") ?? ""
        return nameFamily.replacingOccurrences(of: "familyName: ", with: "")
    }
    
    func loadUser() async -> [User]? {
        do {
            let records = try await self.cloud.fetchSharedPrivatedRecords(recordType: User.getType(), predicate: nil)
            var users: [User] = []
            for record in records {
                guard let user = await User(record: record) else { return nil }
                    users.append(user)
            }
            return users
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func loadGoals() async {
        do {
            guard let goals = try await fecthGoals() else { return  }
            DispatchQueue.main.async {
                self.goals = goals
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func loadSpentsCards() async -> [SpentsCard]? {
        guard let records = try? await cloud.fetchSharedPrivatedRecords(recordType: MethodologySpent.getType(), predicate: nil) else { return nil}
        guard let record = records.first else { return nil}
        guard let methodologySpent = MethodologySpent(record: record) else { return nil}
        var spentsCards: [SpentsCard] = []
        for ind in 0 ..< methodologySpent.namePercent.count {
            if let spentsCard = try? await getSpentsCard(methodologySpent: methodologySpent, index: ind) {
                spentsCards.append(spentsCard)
            }
        }
        return spentsCards
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
    
    private func valuePorcentCategory(categoryPorcent: Int) -> Float {
        return income*(Float(categoryPorcent)/100)
    }
    
    private func avalibleMoneyCategory(categoryPorcent: Int) async throws -> Float? {
        var value: Float = 0.0
        let records = try? await cloud.fetchSharedPrivatedRecords(recordType: Spent.getType(), predicate: "categoryPercent='\(categoryPorcent)'")
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
            guard let goal = await Goal(record: record) else { return nil }
            goals.append(goal)
        }
        return goals
    }
    
}

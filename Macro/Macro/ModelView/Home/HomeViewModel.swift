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
    var income: Float = UserDefaults.standard.float(forKey: "income")
    var methodologyGoals: MethodologyGoal?
    @Published var users: [User] = []
    @Published var goals: [Goal] = []
    @Published var spentsCards: [SpentsCard] = []
    
    init() {
        Task {
            let namePercent = (UserDefaults.standard.array(forKey: "methodologySpent.namePercent") as? [String] ?? [])
            let valuesPercent = (UserDefaults.standard.array(forKey: "methodologySpent.valuesPercent") as? [Int] ?? [])
            await getSpentsCards(namePercent: namePercent, valuesPercent: valuesPercent)
        }

        Task.init {
            await loadGoals()
        }
        Task.init {
            methodologyGoals = try await fecthMethodologyGoal()
        }
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
            await loadMethodologySpent()
        }

    }
    
    func getUserName() -> String {
        let nameFamily = users.first?.name.replacingOccurrences(of: "givenName:", with: "") ?? ""
        return nameFamily.replacingOccurrences(of: "familyName: ", with: "")
    }
    
    func loadUser() async -> [User]? {
        do {
            let predicate = NSPredicate(value: true)
            let records = try await self.cloud.fetchSharedPrivatedRecords(recordType: User.getType(), predicate: predicate)
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
    
    func loadMethodologySpent() async {
        let predicate = NSPredicate(value: true)
        guard let records = try? await cloud.fetchSharedPrivatedRecords(recordType: MethodologySpent.getType(), predicate: predicate) else { return }
        guard let record = records.first else { return }
        guard let methodologySpent = MethodologySpent(record: record) else { return }
        UserDefaults.standard.set(methodologySpent.valuesPercent, forKey: "methodologySpent.valuesPercent")
        UserDefaults.standard.set(methodologySpent.namePercent, forKey: "methodologySpent.namePercent")
    }
    
    private func getSpentsCards(namePercent: [String], valuesPercent: [Int]) async {
        for index in 0 ..< namePercent.count {
            Task {
                do {
                    guard let avalibleMoney = try await self.avalibleMoneyCategory(categoryPorcent: valuesPercent[index]) else { return }
                    let moneySpented = try await self.spentedMoneyCategory(categoryPorcent: valuesPercent[index])
                    let spentsCard = SpentsCard(id: index, valuesPercent: valuesPercent[index], namePercent: namePercent[index], moneySpented: moneySpented, avalibleMoney: avalibleMoney )
                    DispatchQueue.main.async {
                        self.spentsCards.append(spentsCard)
                    }
                } catch let error {
                        print(error.localizedDescription)
                }
            }
        }
    }
    
    private func valuePorcentCategory(categoryPorcent: Int) -> Float {
        return income*(Float(categoryPorcent)/100)
    }
    
    private func avalibleMoneyCategory(categoryPorcent: Int) async throws -> Float? {
        let value = try await spentedMoneyCategory(categoryPorcent: categoryPorcent)
        let total = valuePorcentCategory(categoryPorcent: categoryPorcent)
        return  total - value
    }
    
    private func spentedMoneyCategory(categoryPorcent: Int) async throws -> Float {
        var value: Float = 0.0
        let predicate = NSPredicate(format: "categoryPercent='\(categoryPorcent)'")
        let records = try? await cloud.fetchSharedPrivatedRecords(recordType: Spent.getType(), predicate: predicate)
        guard let records = records else { return 0.0 }
        for record in records {
            guard let spent = Spent(record: record) else { return 0.0 }
            value += spent.value
        }
        return value
    }
    
    private func fecthGoals() async throws -> [Goal]? {
        var goals: [Goal] = []
        let predicate = NSPredicate(value: true)
        let records = try? await cloud.fetchSharedPrivatedRecords(recordType: Goal.getType(), predicate: predicate)
        guard let records = records else { return nil }
        for record in records {
            guard let goal = await Goal(record: record) else { return nil }
            goals.append(goal)
        }
        return goals
    }
    
    private func fecthMethodologyGoal() async throws -> MethodologyGoal? {
        var methodologyGoal: MethodologyGoal?
        let predicate = NSPredicate(value: true)
        let records = try? await cloud.fetchSharedPrivatedRecords(recordType: MethodologyGoal.getType(), predicate: predicate)
        guard let records = records else { return nil }
        for record in records {
            guard let methodology = MethodologyGoal(record: record) else { return nil }
            methodologyGoal = methodology
        }
        return methodologyGoal
    }
    
}

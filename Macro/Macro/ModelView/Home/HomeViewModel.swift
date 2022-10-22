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
    @Published var dictionarySpent: [[Spent]] = []
    @Published var users: [User] = []
    @Published var goals: [Goal] = []
    @Published var spentsCards: [SpentsCard] = []
    
    init() {
        let namePercent = (UserDefaults.standard.array(forKey: "methodologySpent.namePercent") as? [String] ?? [])
        let valuesPercent = (UserDefaults.standard.array(forKey: "methodologySpent.valuesPercent") as? [Int] ?? [])
        for _ in valuesPercent {
            dictionarySpent.append([])
        }
        getSpentsCards(namePercent: namePercent, valuesPercent: valuesPercent)
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
    
    private func getSpentsCards(namePercent: [String], valuesPercent: [Int]) {
        for index in 0 ..< namePercent.count {
            Task {
                do {
                    let categoryPorcent = valuesPercent[index]
                    let total = valuePorcentCategory(categoryPorcent: categoryPorcent)
                    let spents: [Spent] = try await fetchSpent(categoryPorcent: categoryPorcent)
                    let moneySpented = self.spentedMoneyCategory(spents: spents)
                    let spentsCard = SpentsCard(id: index, valuesPercent: categoryPorcent, namePercent: namePercent[index], moneySpented: moneySpented, avalibleMoney: total - moneySpented )
                    DispatchQueue.main.async {
                        self.dictionarySpent[index] = spents
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

    private func spentedMoneyCategory(spents: [Spent]) -> Float {
        var value: Float = 0.0
        for spent in spents {
            value += spent.value
        }
        return value
    }
    
    private func fetchSpent(categoryPorcent: Int) async throws -> [Spent] {
        var spents: [Spent] = []
        let predicate = NSPredicate(format: "categoryPercent == \(categoryPorcent) ")
        let records = try? await cloud.fetchSharedPrivatedRecords(recordType: Spent.getType(), predicate: predicate)
        guard let records = records else { return [] }
        for record in records {
            guard let spent = Spent(record: record) else { return [] }
            spents.append(spent)
        }
        return spents
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

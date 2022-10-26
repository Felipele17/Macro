//
//  MacroViewModel.swift
//  Macro
//
//  Created by Gabriele Namie on 24/10/22.
//

import SwiftUI

class MacroViewModel: ObservableObject {
    let cloud = CloudKitModel.shared
    var methodologyGoals: MethodologyGoal?
    var income: Float = UserDefaults.standard.float(forKey: "income")
    @Published var users: [User] = []
    @Published var dictionarySpent: [[Spent]] = []
    @Published var goals: [Goal] = []
    @Published var spentsCards: [SpentsCard?] = []
    @Published var checkData: [Bool] = [false, false]
    
    init() {
        Task.init {
            guard let methodologySpent = try await loadMethodologySpent() else { return }
            let namePercent = methodologySpent.namePercent
            let valuesPercent = methodologySpent.valuesPercent
            for _ in namePercent {
                DispatchQueue.main.async {
                    self.spentsCards.append(nil)
                    self.dictionarySpent.append([])
                    self.checkData.append(false)
                }
            }
            loadSpentsCards(namePercent: namePercent, valuesPercent: valuesPercent)
        }
        Task.init {
            await loadGoals()
            DispatchQueue.main.async {
                let last = self.checkData.count-1
                self.checkData.replaceSubrange( last...last, with: [true])
            }
        }
        Task.init {
            methodologyGoals = try await fecthMethodologyGoal()
            DispatchQueue.main.async {
                let last = self.checkData.count-2
                self.checkData.replaceSubrange( last...last, with: [true])
            }
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
    }
    
    func isReady() -> Bool {
        for check in checkData {
            if !check {
                return false
            }
        }
        return true
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
            print("Home - loadUser")
            print(error.localizedDescription)
            return nil
        }
    }
    
    func loadMethodologySpent() async throws -> MethodologySpent? {
        let predicate = NSPredicate(value: true)
        do {
            let records = try await cloud.fetchSharedPrivatedRecords(recordType: MethodologySpent.getType(), predicate: predicate)
            guard let record = records.first else { return nil }
            guard let methodologySpent = MethodologySpent(record: record) else { return nil }
            return methodologySpent
        } catch let error {
            print("Home - loadMethodologySpent")
            print(error.localizedDescription)
            return nil
        }
    }
    
    func loadGoals() async {
        do {
            guard let goals = try await fecthGoals() else { return }
            DispatchQueue.main.async {
                self.goals = goals
            }
        } catch let error {
            print("Home - loadGoals")
            print(error.localizedDescription)
        }
    }
    func getUserName() -> String {
        let nameFamily = users.first?.name.replacingOccurrences(of: "givenName:", with: "") ?? ""
        return nameFamily.replacingOccurrences(of: "familyName: ", with: "")
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
    
    private func loadSpentsCards(namePercent: [String], valuesPercent: [Int]) {
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
                        self.spentsCards[index] = spentsCard
                        self.checkData[index] = true
                    }
                } catch let error {
                    print("Home - getSpentsCards")
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getSpentsCards() -> [SpentsCard] {
        var spentsCards: [SpentsCard] = []
        for spentsCard in self.spentsCards {
            if let spentsCard = spentsCard {
                spentsCards.append(spentsCard)
            }
        }
        return spentsCards
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

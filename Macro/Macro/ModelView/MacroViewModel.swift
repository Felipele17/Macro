//
//  MacroViewModel.swift
//  Macro
//
//  Created by Gabriele Namie on 24/10/22.
//

import SwiftUI
import Network

class MacroViewModel: ObservableObject {
    let cloud = CloudKitModel.shared
    var methodologyGoals: MethodologyGoal?
    var income: Float = UserDefaults.standard.float(forKey: "income")
    let monitor = NWPathMonitor()
    var didLoad = false
    @Published var isConect = false
    @Published var users: [User] = []
    @Published var dictionarySpent: [[Spent]] = []
    @Published var goals: [Goal] = []
    @Published var spentsCards: [SpentsCard] = []
    @Published var checkData: [Bool] = [false, false]
    
    init() {
        interntMonitorOn()
    }
    
    func loadData() {
        didLoad = true
        let namePercent = (UserDefaults.standard.array(forKey: "methodologySpent.namePercent") as? [String] ?? [])
        let valuesPercent = (UserDefaults.standard.array(forKey: "methodologySpent.valuesPercent") as? [Int] ?? [])
        for _ in valuesPercent {
            dictionarySpent.append([])
            checkData.append(false)
        }
        getSpentsCards(namePercent: namePercent, valuesPercent: valuesPercent)
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
                UserDefaults.standard.set(self.income, forKey: "income")
            }
        }
        Task.init {
            await loadMethodologySpent()
        }
    }
    
    func interntMonitorOn() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    self.isConect = true
                }
            } else {
                DispatchQueue.main.async {
                    self.isConect = false
                    self.didLoad = false
                    self.checkData = [false, false]
                    self.users = []
                    self.dictionarySpent = []
                    self.goals = []
                    self.spentsCards = []
                }
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
    func isReady() -> Bool {
        if isConect {
            if !didLoad {
                loadData()
            }
            var ready = true
            for check in checkData {
                ready = ready && check
            }
            return ready
        }
        return false
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
    
    func loadMethodologySpent() async {
        let predicate = NSPredicate(value: true)
        guard let records = try? await cloud.fetchSharedPrivatedRecords(recordType: MethodologySpent.getType(), predicate: predicate) else { return }
        guard let record = records.first else { return }
        guard let methodologySpent = MethodologySpent(record: record) else { return }
        UserDefaults.standard.set(methodologySpent.valuesPercent, forKey: "methodologySpent.valuesPercent")
        UserDefaults.standard.set(methodologySpent.namePercent, forKey: "methodologySpent.namePercent")
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
    
    private func getSpentsCards(namePercent: [String], valuesPercent: [Int]) {
        for index in 0 ..< namePercent.count {
            Task {
                do {
                    let categoryPorcent = valuesPercent[index]
                    let total = valuePorcentCategory(categoryPorcent: categoryPorcent)
                    let spents: [Spent] = try await fetchSpent(categoryPorcent: categoryPorcent)
                    let moneySpented = self.spentedMoneyCategory(spents: spents)
                    let spentsCard = SpentsCard(id: index, valuesPercent: categoryPorcent, namePercent: namePercent[index], moneySpented: moneySpented, availableMoney: total - moneySpented )
                    DispatchQueue.main.async {
                        self.dictionarySpent[index] = spents
                        self.spentsCards.append(spentsCard)
                        self.checkData[index] = true
                    }
                } catch let error {
                    print("Home - getSpentsCards")
                    print(error.localizedDescription)
                }
            }
        }
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

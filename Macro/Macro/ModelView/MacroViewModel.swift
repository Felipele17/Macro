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
    var methodologySpent: MethodologySpent?
    var income: Float = UserDefaults.standard.float(forKey: "income")
    let monitor = NWPathMonitor()
    @Published var isConect = false
    @Published var isFinishedLoad = false
    @Published var users: [User] = []
    @Published var matrixSpent: [[Spent]] = []
    @Published var goals: [Goal] = []
    @Published var spentsCards: [SpentsCard] = []
    @Published var checkData: [String: EnumStatusFecth] = [:] {
        didSet {
            isFinishedLoad = isReady()
        }
    }
    
    init() {
        loadData()
        interntMonitorOn()
        self.income = UserDefault.getIncome()
    }
    
    func loadData() {
        loadMethodologyGoals()
        loadGoals()
        loadSpentsCards()
        loadUser()
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
                    self.isFinishedLoad = false
                    self.checkData = [:]
                    self.users = []
                    self.matrixSpent = []
                    self.goals = []
                    self.spentsCards = []
                }
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
    func isReady() -> Bool {
        print(checkData)
        let check = checkData.values.first { $0 == .loading }
        if check == nil { return true }
        return false
    }
    
    // MARK: Load
    
    func loadSpentsCards() {
        Task.init {
            DispatchQueue.main.async {
                self.checkData["SpentsCards"] = .loading
            }
            guard let methodologySpent = try await getMethodologySpent() else {
                DispatchQueue.main.async {
                    self.checkData["SpentsCards"] = .error
                }
                return
            }
            let namePercent = methodologySpent.namePercent
            let valuesPercent = methodologySpent.valuesPercent
            DispatchQueue.main.async {
                self.methodologySpent = methodologySpent
            }
            for value in valuesPercent {
                DispatchQueue.main.async {
                    self.spentsCards.append(SpentsCard())
                    self.matrixSpent.append([])
                    self.checkData["\(value)spent"] = .loading
                }
            }
            getSpentsCards(namePercent: namePercent, valuesPercent: valuesPercent)
            DispatchQueue.main.async {
                self.checkData["SpentsCards"] = .sucess
            }
            print("loadSpentsCards")
        }
    }
    
    func loadUser() {
        Task.init {
            guard let users = await getUser() else { return }
            DispatchQueue.main.async {
                self.users = users
                self.income = 0
                for user in users {
                    self.income += user.income
                }
                UserDefault.setIncome(income: self.income)
            }
            print("loadUser")
        }
    }
    
    func loadGoals() {
        Task.init {
            DispatchQueue.main.async {
                self.checkData["goal"] = .loading
            }
            await getGoals()
            DispatchQueue.main.async {
                if self.checkData["goal"] == .loading {
                    self.checkData["goal"] = .sucess
                }
            }
            print("loadGoals")
        }
    }
    
    func loadMethodologyGoals() {
        Task.init {
            DispatchQueue.main.async {
                self.checkData["methodologyGoals"] = .loading

            }
            methodologyGoals = try await fecthMethodologyGoal()
            DispatchQueue.main.async {
            if self.checkData["methodologyGoals"] == .loading {
                    self.checkData["methodologyGoals"] = .sucess
                }
            }
            print("loadMethodologyGoals")
        }
        
    }

    func reload(type: String) {
        if type == Goal.getType() && ObservableDataBase.shared.needFetchGoal {
            Task {
                await getGoals()
            }
        } else if type == Spent.getType() && ObservableDataBase.shared.needFetchSpent {
            guard let methodologySpent = methodologySpent else { return }
            getSpentsCards(namePercent: methodologySpent.namePercent, valuesPercent: methodologySpent.valuesPercent)
        } else {
            print("error")
        }
    }
    
    // MARK: Get
    
    func getUser() async -> [User]? {
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
    
    func getMethodologySpent() async throws -> MethodologySpent? {
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
    
    func getGoals() async {
        do {
            guard let goals = try await fecthGoals() else { return }
            DispatchQueue.main.async {
                self.goals = goals
            }
        } catch let error {
            print("Home - loadGoals")
            print(error.localizedDescription)
            DispatchQueue.main.async {
                self.checkData["goal"] = .error
            }
        }
    }
    
    private func getSpentsCards(namePercent: [String], valuesPercent: [Int]) {
        for index in 0 ..< namePercent.count {
            Task {
                do {
                    let categoryPorcent = valuesPercent[index]
                    let total = self.valuePorcentCategory(categoryPorcent: categoryPorcent)
                    let spents: [Spent] = try await fetchSpent(categoryPorcent: categoryPorcent)
                    let moneySpented = self.spentedMoneyCategory(spents: spents)
                    let spentsCard = SpentsCard(id: index, valuesPercent: categoryPorcent, namePercent: namePercent[index], moneySpented: moneySpented, availableMoney: total - moneySpented, totalMoney: total )
                    DispatchQueue.main.async {
                        self.matrixSpent[index] = spents
                        self.spentsCards[index] = spentsCard
                        self.checkData["\(spentsCard.valuesPercent)spent"] = .sucess
                    }
                } catch let error {
                    print("Home - getSpentsCards")
                    print(error.localizedDescription)
                    DispatchQueue.main.async {
                        self.checkData["\(valuesPercent[index])spent"] = .error
                    }
                }
                print("getSpentsCards: \(namePercent[index])")
            }
        }
    }
    
    // MARK: convert
    
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
    
    // MARK: fecth
    
    private func fetchSpent(categoryPorcent: Int) async throws -> [Spent] {
        var spents: [Spent] = []
        var component = Date().get(.day, .month, .year)
        component.year = component.month == 1 ? (component.year ?? 2)-1 : component.year
        component.month = component.day ?? 21 <= 21 ? (component.month ?? 2)-1 : component.month
        component.day = 21
        component.hour = 0
        component.minute = 0
        component.second = 0
        print(component)
        let date: Date = NSCalendar.current.date(from: component) ?? Date.now
        let predicate = NSPredicate(format: "categoryPercent == \(categoryPorcent) && date >= %@", NSDate(timeInterval: 0, since: date))
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
        do {
            let records = try await cloud.fetchSharedPrivatedRecords(recordType: MethodologyGoal.getType(), predicate: predicate)
            for record in records {
                guard let methodology = MethodologyGoal(record: record) else {
                    DispatchQueue.main.async {
                        self.checkData["methodologyGoals"] = .error
                    }
                    return nil
                }
                methodologyGoal = methodology
            }
            return methodologyGoal
        } catch let error {
            DispatchQueue.main.async {
                self.checkData["methodologyGoals"] = .error
            }
            print("fecthMethodologyGoal")
            print(error.localizedDescription)
            return nil
        }
    }
}

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

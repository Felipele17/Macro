//
//  Meta.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import Foundation
import CloudKit

struct Goal: DataModelProtocol, Identifiable {

    var id: UUID
    var title: String
    var value: Float
    var weeks: Int // Reference to the weeks that are completed to complet the goal
    var motivation: String? // Reference the frase that is presented in the card
    var priority: Int // Reference the priority of the goal
    var methodologyGoal: MethodologyGoal? // On iCloud this is store as a UUID
    
    init(title: String, value: Float, weeks: Int, motivation: String?, priority: Int, methodologyGoal: MethodologyGoal?) {
        self.id = UUID()
        self.title = title
        self.value = value
        self.weeks = weeks
        self.priority = priority
        self.motivation = motivation
        self.methodologyGoal = methodologyGoal
    }
    
    init? (record: CKRecord) async {
        let id = record.recordID.recordName
        guard let  title = record["title"] as? String else { return nil }
        guard let  value = record["value"] as? Float else { return nil }
        guard let  weeks = record["weeks"] as? Int else { return nil }
        guard let  motivation = record["motivation"] as? String? else { return nil }
        guard let  methodologyGoal = record["methodologyGoal"] as? String else { return nil } // Its necessary to fecth the UUID
        guard let  priority = record["priority"] as? Int else { return nil }
        
        guard let id = UUID(uuidString: id) else { return nil }
        
        self.id = id
        self.title = title
        self.value = value
        self.weeks = weeks
        self.motivation = motivation
        self.priority = priority
        guard let record = try? await CloudKitModel.shared.fetchByID(id: methodologyGoal, tipe: MethodologyGoal.getType()) else { return }
        guard let methodologyGoal = MethodologyGoal(record: record) else { return }
        self.methodologyGoal = methodologyGoal
    }
    
    func getType() -> String {
        return "Goal"
    }
    
    static func getType() -> String {
        return "Goal"
    }
    
    func getID() -> UUID {
        return id
    }
    
    func getProperties() -> [String] {
        return["title", "value", "weeks", "motivation", "priority", "methodologyGoal"]
    }
    
    func getData() -> [String: Any?] {
        return["title": title, "value": value, "weeks": weeks, "motivation": motivation ?? "", "priority": priority, "methodologyGoal": methodologyGoal?.idName.description]
    }
    
    func getAllMoneySave() -> Float {
        var total: Float = 0.0
        for index in 0 ... weeks {
            total += getMoneySaveForWeek(week: index)
        }
       return total
    }
    
    func getNeedMoneyToCompleteGoal() -> Float {
        return value - getAllMoneySave()
    }
    
    func getMoneySaveForWeek(week: Int) -> Float {
        return Float(week) * getMoneySavePerWeek()
    }
    
    func getMoneySavePerWeek() -> Float {
        let num = Float(methodologyGoal?.weeks ?? 0)
        return (value*2.0)/(num*(num+1.0))
    }
    
    func getArrayWeeksCheck() -> [Int] {
        var arrayWeek: [Int] = []
        if weeks <= 0 { return arrayWeek }
        for week in 1...weeks {
            arrayWeek.append(week)
        }
        return arrayWeek
    }
    
    func getArrayWeeksNotCheck() -> [Int] {
        var arrayWeek: [Int] = []
        guard let methodologyGoalWeeks = methodologyGoal?.weeks else { return arrayWeek }
        if weeks == methodologyGoalWeeks - 1 { return [methodologyGoalWeeks] }
        if weeks == methodologyGoalWeeks { return [] }
        for week in weeks+2 ... methodologyGoalWeeks {
            arrayWeek.append(week)
        }
        return arrayWeek
    }
    
    static func startGoals(methodologyGoals: MethodologyGoal) -> Goal {
        return Goal(title: "", value: 0.0, weeks: 0, motivation: "", priority: 1, methodologyGoal: methodologyGoals)
    }
    
}

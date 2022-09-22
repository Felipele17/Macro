//
//  Meta.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import Foundation
import CloudKit

class Goal: DataModelProtocol {

    var idName: UUID
    var title: String
    var value: Float
    var weeks: Int // Reference to the weeks that are completed to complet the goal
    var motivation: String? // Reference the frase that is presented in the card
    var priority: Int // Reference the priority of the goal
    var methodologyGoal: MethodologyGoal? // On iCloud this is store as a UUID
    
    init(title: String, value: Float, weeks: Int, motivation: String?, priority: Int, methodologyGoal: MethodologyGoal) {
        self.idName = UUID()
        self.title = title
        self.value = value
        self.weeks = weeks
        self.priority = priority
        self.motivation = motivation
        self.methodologyGoal = methodologyGoal
    }
    
    required init?(record: CKRecord) {
        guard let  idName = record["recordName"] as? String else { return nil }
        guard let  title = record["title"] as? String else { return nil }
        guard let  value = record["value"] as? Float else { return nil }
        guard let  weeks = record["weeks"] as? Int else { return nil }
        guard let  motivation = record["motivation"] as? String? else { return nil }
        guard let  methodologyGoal = record["methodologyGoal"] as? String else { return nil } // Its necessary to fecth the UUID
        guard let  priority = record["priority"] as? Int else { return nil }
        
        guard let idName = UUID(uuidString: idName) else { return nil }
        
        self.idName = idName
        self.title = title
        self.value = value
        self.weeks = weeks
        self.motivation = motivation
        self.priority = priority
        Task.init {
            guard let record = try await CloudKitModel.shared.fetchByID(id: methodologyGoal, tipe: MethodologyGoal.getType()) else { return }
            guard let methodologyGoal = MethodologyGoal(record: record) else { return }
            self.methodologyGoal = methodologyGoal
        }
    }
    
    static func getType() -> String {
        return "Meta"
    }
    
    func getID() -> UUID {
        return idName
    }
    
    func getProperties() -> [String] {
        return["title", "value", "check", "category"]
    }
    
    func getData() -> [String: Any?] {
        return["title": title, "value": value, "weeks": weeks, "motivation": motivation ?? "", "priority": priority, "methodologyGoal": methodologyGoal]
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
}

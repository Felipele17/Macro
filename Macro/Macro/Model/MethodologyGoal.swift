//
//  Methodology.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import Foundation
import CloudKit
class MethodologyGoal: DataModelProtocol {
    var idName: UUID
    
    var weeks: Int // → (true → o dinheiro entra em forma de PA [necessariamente crescente], false → o dinheiro entra de forma linear [constante])
    
    var crescent: Bool  // (→Template categorias com porcentagens diferentes add futuramente, AKA: nome; haverão vários templates no futuro)
    
    init( weeks: Int, crescent: Bool) {
        self.idName = UUID()
        self.weeks = weeks
        self.crescent = crescent
    }
    
    required init?(record: CKRecord) {
        let idName = record.recordID.recordName
        guard let  weeks = record["weeks"] as? Int else { return nil }
        guard let  crescent = record["crescent"] as? Bool else { return nil }
        
        guard let idName = UUID(uuidString: idName) else { return nil }
        
        self.idName = idName
        self.weeks = weeks
        self.crescent = crescent
    }
    
    func getType() -> String {
        return "MethodologyGoal"
    }
    
    static func getType() -> String {
        return "MethodologyGoal"
    }
    
    func getID() -> UUID {
        return idName
    }
    
    func getProperties() -> [String] {
        return ["weeks", "crescent"]
    }
    
    func getData() -> [String: Any?] {
        return ["weeks": weeks, "crescent": crescent]
    }
    
}

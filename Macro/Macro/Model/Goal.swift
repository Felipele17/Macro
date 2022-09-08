//
//  Meta.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import Foundation
import CloudKit

struct Goal: DataModelProtocol {

    var idName: UUID
    var title: String
    var value: Int
    var check: Int
    var category: CategoryGoal
    
    init(title: String, value: Int, check: Int, category: CategoryGoal) {
        self.idName = UUID()
        self.title = title
        self.value = value
        self.category = category
        self.check = check
    }
    
    init?(record: CKRecord) {
        guard let  idName = record["recordName"] as? String else { return nil }
        guard let  title = record["title"] as? String else { return nil }
        guard let  value = record["value"] as? Int else { return nil }
        guard let  check = record["check"] as? Int else { return nil }
        guard let  category = record["category"] as? String else { return nil }
        
        guard let idName = UUID(uuidString: idName) else { return nil }
        guard let category = CategoryGoal.init(rawValue: category) else { return nil }
        
        self.idName = idName
        self.category = category
        self.check = check
        self.title = title
        self.value = value
    }
    
    func getType() -> String {
        return "Meta"
    }
    
    func getID() -> UUID {
        return idName
    }
    
    func getProperties() -> [String] {
        return["title", "value", "check", "category"]
    }
    
    func getData() -> [String: Any] {
        return["title": title, "value": value, "check": check, "category": category.rawValue]
    }

}

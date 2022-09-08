//
//  Gasto.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import Foundation
import CloudKit

struct Spent: DataModelProtocol {
    
    var idName: UUID
    var title: String
    var value: Int
    var category: CategorySpent
    
    init(title: String, value: Int, category: CategorySpent) {
        self.idName = UUID()
        self.title = title
        self.value = value
        self.category = category
    }
    
    init?(record: CKRecord) {
        guard let  idName = record["recordName"] as? String else { return nil }
        guard let  title = record["title"] as? String else { return nil }
        guard let  value = record["value"] as? Int else { return nil }
        guard let  category = record["category"] as? String else { return nil }
        
        guard let idName = UUID(uuidString: idName) else { return nil }
        guard let category = CategorySpent.init(rawValue: category) else { return nil }
        
        self.idName = idName
        self.category = category
        self.title = title
        self.value = value
    }
    
    func getType() -> String {
        return "Spent"
    }
    
    func getID() -> UUID {
        return idName
    }
    
    func getProperties() -> [String] {
        return ["title", "value", "category"]
    }
    
    func getData() -> [String: Any] {
        return ["title": title, "value": value, "category": category.rawValue]
    }
}

//
//  Gasto.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import Foundation

struct Spent: DataModelProtocol {
    
    var ID: UUID
    var title: String
    var value: Int
    var category: CategorySpent
    
    init(title: String, value: Int, category: CategorySpent) {
        self.ID = UUID()
        self.title = title
        self.value = value
        self.category = category
    }
    
    func getType() -> String {
        return "Spent"
    }
    
    func getID() -> UUID {
        return ID
    }
    
    func getProperties() -> [String] {
        return ["title","value","category"]
    }
    
    func getData() -> [String : Any] {
        return ["title":title,"value":value,"category":category.rawValue]
    }
}

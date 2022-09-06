//
//  Meta.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import Foundation

struct Goal: DataModelProtocol {

    var ID: UUID
    var title: String
    var value: Int
    var check: Int
    var categoria: CategoryGoal
    
    init(title: String, value: Int, check:Int, categoria: CategoryGoal) {
        self.ID = UUID()
        self.title = title
        self.value = value
        self.categoria = categoria
        self.check = check
    }
    
    func getType() -> String {
        return "Meta"
    }
    
    func getID() -> UUID {
        return ID
    }
    
    func getProperties() -> [String] {
        return["title","value","check","categoria"]
    }
    
    func getData() -> [String : Any] {
        return["title":title,"value":value,"check":check,"categoria":categoria.rawValue]
    }

}

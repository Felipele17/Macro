//
//  CategoriaGastoEnum.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import Foundation
import CloudKit
class MethodologySpent: DataModelProtocol {
    var idName: UUID
    
    var valuesPercent: [Int] // (→ Referente à porcentagem da quantidade de dinheiro total)
    
    var nameCategory: String // (→ Template categorias com porcentagens diferentes add futuramente, AKA: nome; haverão vários templates no futuro)
    
    init(valuesPercent: [Int], nameCategory: String) {
        self.idName = UUID()
        self.valuesPercent = valuesPercent
        self.nameCategory = nameCategory
    }
    
    required init?(record: CKRecord) {
        guard let  idName = record["recordName"] as? String else { return nil }
        guard let  valuesPercent = record["valuesPercent"] as? [Int] else { return nil }
        guard let  nameCategory = record["nameCategory"] as? String else { return nil }
        
        guard let idName = UUID(uuidString: idName) else { return nil }
        
        self.idName = idName
        self.valuesPercent = valuesPercent
        self.nameCategory = nameCategory
    }
    
    static func getType() -> String {
        return "MethodologySpent"
    }
    
    func getID() -> UUID {
        return idName
    }
    
    func getProperties() -> [String] {
        return ["valuesPercent", "nameCategory"]
    }
    
    func getData() -> [String: Any?] {
        return ["valuesPercent": valuesPercent, "nameCategory": nameCategory]
    }
    
}

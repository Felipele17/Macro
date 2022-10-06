//
//  Perfil.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import Foundation
import CloudKit

class User: DataModelProtocol {
    var idName: UUID
    var name: String
    var income: Float
    var partner: String
    var dueData: Int
    // (→ Array de index mostrando qual notificação foi ligada, [1,2] nesse caso a segunda e terceira notificação foram ligadas)
    var notification: [Int]
    var methodologySpent: MethodologySpent?
    
    init( name: String, income: Float, dueData: Int, partner: String, notification: [Int], methodologySpent: MethodologySpent) {
        self.idName = UUID()
        self.name = name
        self.income = income
        self.partner = partner
        self.dueData = dueData
        self.notification = notification
        self.methodologySpent = methodologySpent
    }
    
    required init?(record: CKRecord) {
        guard let  idName = record["idName"] as? String else { return nil }
        guard let  name = record["name"] as? String else { return nil }
        guard let  income = record["income"] as? Float else { return nil }
        guard let  partner = record["partner"] as? String else { return nil }
        guard let  dueData = record["dueData"] as? Int else { return nil }
        guard let  notification = record["notification"] as? [Int] else { return nil }
        guard let  methodologySpent = record["methodologySpent"] as? String else { return nil }
        
        guard let idName = UUID(uuidString: idName) else { return nil }
        
        self.idName = idName
        self.name = name
        self.income = income
        self.partner = partner
        self.dueData = dueData
        self.notification = notification
        Task.init {
            guard let record = try await CloudKitModel.shared.fetchByID(id: methodologySpent, tipe: MethodologySpent.getType()) else { return }
            guard let methodologySpent = MethodologySpent(record: record) else { return }
            self.methodologySpent = methodologySpent
        }
    }
    
    static  func getType() -> String {
        return "User"
    }
    
    func getID() -> UUID {
        return idName
    }
    
    func getProperties() -> [String] {
        return ["name", "income", "partner", "dueData", "notification", "methodologySpent"]
    }
    
    func getData() -> [String: Any?] {
        return ["name": name, "income": income, "partner": partner, "dueData": dueData, "notification": notification, "methodologySpent": methodologySpent?.idName.description]
    }
    
}

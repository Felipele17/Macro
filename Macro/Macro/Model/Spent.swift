//
//  Gasto.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import Foundation
import CloudKit

class Spent: DataModelProtocol, Identifiable {
    
    var idName: UUID
    var title: String
    var value: Float
    var icon: String
    var date: Date
    var categoryPercent: Int
    
    init(title: String, value: Float, icon: String,
         date: Date,
         categoryPercent: Int) {
        self.idName = UUID()
        self.title = title
        self.value = value
        self.icon = icon
        self.date = date
        self.categoryPercent = categoryPercent
    }
    
    required init?(record: CKRecord) {
        let idName = record.recordID.recordName
        guard let  title = record["title"] as? String else { return nil }
        guard let  value = record["value"] as? Float else { return nil }
        guard let  icon = record["icon"] as? String else { return nil }
        guard let  date = record["date"] as? Date else { return nil }
        guard let  categoryPercent = record["categoryPercent"] as? Int else { return nil }
        guard let idName = UUID(uuidString: idName) else { return nil }
        self.idName = idName
        self.title = title
        self.value = value
        self.icon = icon
        self.date = date
        self.categoryPercent = categoryPercent
    }
    
    func getType() -> String {
        return "Spent"
    }
    
    static func getType() -> String {
        return "Spent"
    }
    
    func getID() -> UUID {
        return idName
    }
    
    func getProperties() -> [String] {
        return ["title", "value", "icon", "date", "categoryPercent"]
    }
    
    func getData() -> [String: Any?] {
        return ["title": title, "value": value, "icon": icon,
                "date": date,
                "categoryPercent": categoryPercent]
    }
    
    static func emptyMock(category: Int) -> Spent {
        return Spent(title: "", value: 0.0, icon: "", date: Date.now, categoryPercent: category)
    }
}

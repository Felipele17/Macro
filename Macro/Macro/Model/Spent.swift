//
//  Gasto.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import Foundation
import CloudKit

struct Spent: DataModelProtocol, Identifiable {
    
    var id: UUID
    var title: String
    var value: Float
    var icon: String
    var date: Date
    var categoryPercent: Int
    
    init(id: UUID, title: String, value: Float, icon: String,
         date: Date,
         categoryPercent: Int) {
        self.id = id
        self.title = title
        self.value = value
        self.icon = icon
        self.date = date
        self.categoryPercent = categoryPercent
    }
    
    init?(record: CKRecord) {
        let id = record.recordID.recordName
        guard let  title = record["title"] as? String else { return nil }
        guard let  value = record["value"] as? Float else { return nil }
        guard let  icon = record["icon"] as? String else { return nil }
        guard let  date = record["date"] as? Date else { return nil }
        guard let  categoryPercent = record["categoryPercent"] as? Int else { return nil }
        guard let id = UUID(uuidString: id) else { return nil }
        self.id = id
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
        return id
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
        return Spent(id: UUID(), title: "", value: 0.0, icon: "", date: Date.now, categoryPercent: category)
    }
}

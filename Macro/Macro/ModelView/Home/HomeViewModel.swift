//
//  HomeModelView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI
import Foundation

class HomeViewModel: ObservableObject {
    let cloud = CloudKitModel.shared
    var income: Float = 0.0
    var users: [User] = []
    
    init() {
        Task.init {
            let records = try? await self.cloud.fetchSharedPrivatedRecords(recordType: User.getType(), predicate: "")
            guard let records = records else { return }
            for record in records {
                guard let user = User(record: record) else { return }
                users.append(user)
                income += user.income
            }
        }
    }
    
    func categoryPorcent() -> [Int]? {
        var values: [Int] = []
        guard let user = users.first else { return nil }
        guard let valuesPercent = user.methodologySpent?.valuesPercent else { return nil }
        for porcent in valuesPercent {
            values.append(porcent)
        }
        return values
    }
    
    func valuePorcentCategory(categoryPorcent: Int) -> Float? {
        return income/Float(categoryPorcent)
    }
    
    func avalibleMoneyCategory(categoryPorcent: Int) async throws -> Float? {
        var value: Float = 0.0
        let records = try? await cloud.fetchSharedPrivatedRecords(recordType: Spent.getType(), predicate: "categoryPercent == \(categoryPorcent)")
        guard let records = records else { return nil }
        for record in records {
            guard let spent = Spent(record: record) else { return nil }
            value += spent.value
        }
        guard let total = valuePorcentCategory(categoryPorcent: categoryPorcent) else { return nil }
        return  total - value
    }
    
}

//
//  SpentsModelView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import Foundation
import SwiftUI

class SpentViewModel: ObservableObject {
    private let cloud = CloudKitModel.shared
    @Published var spentsCard: Binding<SpentsCard>
    @Published var arraySpents: Binding<[Spent]>
    
    init(spentsCard: Binding<SpentsCard>, arraySpents: Binding<[Spent]>) {
        self.spentsCard = spentsCard
        self.arraySpents = arraySpents
    }
    
    func createSpent(spent: Spent) -> Spent? {
        if spent.title.isEmpty {
            return nil
        }
        if spent.icon.isEmpty {
            return nil
        }
        if spent.value.isZero {
            return nil
        }
        return spent
    }
    
    func postSpent(spent: Spent) -> Bool {
        guard let spent = createSpent(spent: spent) else { return false }
        Task.init {
            try? await cloud.post(model: spent)
        }
        arraySpents.wrappedValue.append(spent)
        spentsCard.wrappedValue.moneySpented += spent.value
        spentsCard.wrappedValue.avalibleMoney -= spent.value
        return true
    }
    
    func deleteSpent(spent: Spent) {
        Task.init {
            await cloud.delete(model: spent)
        }
        arraySpents.wrappedValue.removeAll { elemSpent in
            elemSpent.id == spent.id
        }
        spentsCard.wrappedValue.moneySpented -= spent.value
        spentsCard.wrappedValue.avalibleMoney += spent.value
    }
    
    func editSpent(spent: Spent) -> Bool {
        guard let spent = createSpent(spent: spent) else { return false}
        Task.init {
            await cloud.update(model: spent)
        }
        let origSpentValue: Float = arraySpents.wrappedValue.first { elemSpent in
            elemSpent.id == spent.id
        }?.value ?? 0.0
        
        spentsCard.wrappedValue.moneySpented -= origSpentValue
        spentsCard.wrappedValue.moneySpented += spent.value
        spentsCard.wrappedValue.avalibleMoney += origSpentValue
        spentsCard.wrappedValue.avalibleMoney -= spent.value
        return true
    }
}

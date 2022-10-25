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
    @Binding var spentsCard: SpentsCard
    @Binding var arraySpents: [Spent]
    
    init(spentsCard: Binding<SpentsCard>, arraySpents: Binding<[Spent]>) {
        self._spentsCard = spentsCard
        self._arraySpents = arraySpents
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
        arraySpents.append(spent)
        spentsCard.moneySpented += spent.value
        spentsCard.avalibleMoney -= spent.value
        return true
    }
    
    func deleteSpent(spent: Spent) {
        Task.init {
            await cloud.delete(model: spent)
        }
        arraySpents.removeAll { elemSpent in
            elemSpent.id == spent.id
        }
        spentsCard.moneySpented -= spent.value
        spentsCard.avalibleMoney += spent.value
    }
    
    func editSpent(spent: Spent) -> Bool {
        guard let spent = createSpent(spent: spent) else { return false}
        Task.init {
            await cloud.update(model: spent)
        }
        let origSpentValue: Float = arraySpents.first { elemSpent in
            elemSpent.id == spent.id
        }?.value ?? 0.0
        
        spentsCard.moneySpented -= origSpentValue
        spentsCard.moneySpented += spent.value
        spentsCard.avalibleMoney += origSpentValue
        spentsCard.avalibleMoney -= spent.value
        return true
    }
}

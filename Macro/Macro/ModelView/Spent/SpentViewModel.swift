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
    @Published var spentsCards: [SpentsCard] = []
    @Published var dictionarySpent: [[Spent]] = []
    
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
    
    func postSpent(spent: Spent, spentsCard: SpentsCard) -> Bool {
        let index = spentsCards.firstIndex { sc in
            sc == spentsCard
        }
        guard let index = index else { return false }
        var arraySpents = dictionarySpent[index]
        guard let spent = createSpent(spent: spent) else { return false }
        Task.init {
            try? await cloud.post(model: spent)
        }
        arraySpents.append(spent)
        spentsCards[index].moneySpented += spent.value
        spentsCards[index].avalibleMoney -= spent.value
        dictionarySpent[index] = arraySpents
        return true
    }
    
    func deleteSpent(spent: Spent, spentsCard: SpentsCard) {
        
        let index = spentsCards.firstIndex { sc in
            sc == spentsCard
        }
        guard let index = index else { return }
        var arraySpents = dictionarySpent[index]
        
        Task.init {
            await cloud.delete(model: spent)
        }
        arraySpents.removeAll { elemSpent in
            elemSpent.id == spent.id
        }
        spentsCards[index].moneySpented -= spent.value
        spentsCards[index].avalibleMoney += spent.value
        dictionarySpent[index] = arraySpents
    }
    
    func editSpent(spent: Spent, spentsCard: SpentsCard) -> Bool {
        
        let index = spentsCards.firstIndex { sc in
            sc == spentsCard
        }
        guard let index = index else { return false}
        var arraySpents = dictionarySpent[index]
        
        guard let spent = createSpent(spent: spent) else { return false}
        Task.init {
            await cloud.update(model: spent)
        }
        let origSpentValue: Float = arraySpents.first { elemSpent in
            elemSpent.id == spent.id
        }?.value ?? 0.0
        
        spentsCards[index].moneySpented -= origSpentValue
        spentsCards[index].moneySpented += spent.value
        spentsCards[index].avalibleMoney += origSpentValue
        spentsCards[index].avalibleMoney -= spent.value
        return true
    }
    
    func updateArray(isPost: Bool, newSpent: Spent, spentsCard: SpentsCard) -> Bool {
        
        let index = spentsCards.firstIndex { sc in
            sc == spentsCard
        }
        guard let index = index else { return false}
        var arraySpents = dictionarySpent[index]
        
        if isPost {
            if postSpent(spent: newSpent, spentsCard: spentsCard) {
                arraySpents.append(newSpent)
                return true
            }
            return false
        } else {
            if editSpent(spent: newSpent, spentsCard: spentsCard) {
                let range = arraySpents.firstIndex { spent in
                    spent.id == newSpent.id
                }
                guard let range = range else { return false }
                arraySpents.replaceSubrange(range ... range, with: [newSpent])
                return true
            }
            return false
        }
    }
    
    func getArraySpents(spentsCard: SpentsCard) -> [Spent] {
        let index = spentsCards.firstIndex { sc in
            sc == spentsCard
        }
        guard let index = index else { return []}
        var arraySpents = dictionarySpent[index]
        return arraySpents
    }
    
}

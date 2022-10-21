//
//  SpentsModelView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import Foundation

class SpentViewModel: ObservableObject {
    private let cloud = CloudKitModel.shared
    @Published var spent: Spent
    
    init(spent: Spent) {
        self.spent = spent
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
    
    func postSpent(spent: Spent) -> Spent? {
        guard let spent = createSpent(spent: spent) else { return nil }
        Task.init {
            try? await cloud.post(model: spent)
        }
        return spent
    }
    
    func deleteSpent(spent: Spent) {
        Task.init {
            await cloud.delete(model: spent)
        }
    }
    
    func editSpent(spent: Spent) -> Bool {
        guard let spent = createSpent(spent: spent) else { return false}
        self.spent.title = spent.title
        self.spent.date = spent.date
        self.spent.icon = spent.icon
        self.spent.value = spent.value
        Task.init {
            await cloud.update(model: self.spent)
        }
        return true
    }
}

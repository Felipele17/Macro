//
//  SpentsModelView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import Foundation

class SpentViewModel: ObservableObject {
    private let cloud = CloudKitModel.shared
    @Published var nameSpent = ""
    @Published var iconPicker = "One"
    @Published var valueSpent: Float = 0.0
    @Published var datePickerSpent = Date()
    var categoryPercent: EnumCategoryPercent
    
    init(categoryPercent: EnumCategoryPercent) {
        self.categoryPercent = categoryPercent
    }
    
    func createSpent() -> Spent? {
        if nameSpent.isEmpty {
            return nil
        }
        if iconPicker.isEmpty {
            return nil
        }
        if valueSpent.isZero {
            return nil
        }
        return Spent(title: nameSpent, value: valueSpent, icon: iconPicker, date: datePickerSpent, categoryPercent: categoryPercent)
    }
    
    func postSpent() {
        Task.init {
            guard let spent = createSpent() else {
                return 
            }
            try? await cloud.post(recordType: Spent.getType(), model: spent)
        }
    }
    
    func deleteSpent(spent: Spent) {
        Task.init {
            do {
                try await cloud.delete(model: spent)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func editSpent(spent: Spent) {
        Task.init {
            do {
                try await cloud.update(model: spent)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}

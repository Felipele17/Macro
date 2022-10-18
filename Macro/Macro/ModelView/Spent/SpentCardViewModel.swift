//
//  SpentCardViewModel.swift
//  Macro
//
//  Created by Gabriele Namie on 28/09/22.
//

import Foundation

class SpentCarViewModel: ObservableObject {
    
    @Published var nameSpent = ""
    @Published var iconPicker = "One"
    @Published var valueSpent: Float = 0.0
    @Published var datePickerSpent = Date()
    
    init(nameSpent: String, iconPicker: String, valueSpent: Float, datePickerSpent: Date) {
        self.nameSpent = nameSpent
        self.iconPicker = iconPicker
        self.valueSpent = valueSpent
        self.datePickerSpent = datePickerSpent
    }
    
}

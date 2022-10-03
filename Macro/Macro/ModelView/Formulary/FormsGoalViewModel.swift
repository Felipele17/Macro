//
//  FormsGoalViewModel.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 30/09/22.
//

import Foundation
class FormsGoalViewModel: ObservableObject {
    @Published var goal: Goal
    
    init(goal: Goal) {
        self.goal = goal
    }
    
}

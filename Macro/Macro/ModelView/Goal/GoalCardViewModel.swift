//
//  GoalCardViewModel.swift
//  Macro
//
//  Created by Gabriele Namie on 22/09/22.
//

import SwiftUI

class GoalCardViewModel: ObservableObject {
    @Published var percents: CGFloat = 0.0
    @Published var percentsProgress: CGFloat = 0.0
    
    func calc( goal: Goal) -> CGFloat {
        percents = CGFloat(goal.getAllMoneySave()/goal.value)
        percentsProgress = 220 * percents
        return percentsProgress
    }
    
    func setImagebyPriority(goal: Goal) -> String {
        let priority = goal.priority
        if priority == 1 {
            return "Noz1"
        } else if priority == 2 {
            return "Noz2"
        } else {
            return "Noz3"
        }
    }
}

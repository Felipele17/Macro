//
//  GoalModelView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import Foundation
import SwiftUI
class GoalViewModel: ObservableObject {
    private let cloud = CloudKitModel.shared
    init() {}
    
    func checkWeekGoal(goal: Goal) {
        goal.weeks += 1
        Task.init {
            do {
                try await cloud.upadte(model: goal)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}

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
    @Published var goalField = ""
    @Published var moneyField: Float = 0.0
    @Published var priority: Int = 0
    @Published var motivation = ""
    // var methodologyGoal: MethodologyGoal
    
//    init(methodologyGoal: MethodologyGoal) {
//        self.methodologyGoal = methodologyGoal
//    }
    
    func checkWeekGoal(goal: Goal) {
        goal.weeks += 1
        Task.init {
            do {
                try await cloud.update(model: goal)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
//    func createGoal() -> Goal? {
//        if motivation.isEmpty {
//            return nil
//        }
//        return Goal(title: goalField, value: moneyField, weeks: 0, motivation: motivation, priority: priority, methodologyGoal: methodologyGoal)
//    }
//    
//    func postGoals() {
//        Task.init {
//            guard let goal = createGoal() else {
//                return
//            }
//            try? await cloud.post(recordType: Goal.getType(), model: goal)
//        }
//    }
    
    func deleteGoal(goal: Goal) {
        Task.init {
            await cloud.delete(model: goal)
        }
    }
    
    func editGoal(goal: Goal) {
        Task.init {
            do {
                try await cloud.update(model: goal)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
    }
}

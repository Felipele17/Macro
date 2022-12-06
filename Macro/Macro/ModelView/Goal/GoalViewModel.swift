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
    @Published var goals: [Goal] = []
    @Published var selectedGoal: Goal = Goal.mockGoals(methodologyGoals: nil)
    var methodologyGoals: MethodologyGoal?
    
    func setMethodologyGoals(methodologyGoals: MethodologyGoal?) {
        if methodologyGoals == nil{
            print("methodologyGoals = nil")
        }
        self.selectedGoal = Goal.mockGoals(methodologyGoals: methodologyGoals)
        self.methodologyGoals = methodologyGoals
    }
    
    func addGoal(goal: Goal) {
        Task.init {
            try? await CloudKitModel.shared.post( model: goal)
        }
        goals.append(goal)
        moveCompletedGoalToEnd()
    }
    
    func deleteGoal(goal: Goal) {
        goals.removeAll { goalDeleted in
            goalDeleted.id == goal.id
        }
        Task.init {
            await cloud.delete(model: goal)
        }
    }
    
    func isGoalFinished(goal: Goal) -> Bool {
        guard let methodologyWeeks = goal.methodologyGoal?.weeks else { return false}
        if goal.weeks >= methodologyWeeks {

            return true
        }
        return false
    }
    
    func editGoal(goal: Goal) {
        let index = goals.firstIndex { elemGoal in
            elemGoal.id == goal.id
        }
        guard let index = index else { return }
        DispatchQueue.main.async {
            self.goals.replaceSubrange( index ... index, with: [goal])
            self.moveCompletedGoalToEnd()
        }
        Task.init {
            await cloud.update(model: goal)
        }
    }
    
    func moveCompletedGoalToEnd() {
        for goal in goals {
            if goal.weeks >= methodologyGoals?.weeks ?? 0 {
                goals.removeAll { goalInArray in
                    goalInArray.id == goal.id
                }
                goals.append(goal)
            }
        }
    }
    
    func calc( goal: Goal) -> CGFloat {
        let percents = CGFloat(goal.getAllMoneySave()/goal.value)
        let percentsProgress = 220 * percents
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

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
    var methodologyGoals: MethodologyGoal?
    @Published var goalField = ""
    @Published var moneyField: Float = 0.0
    @Published var priority: Int = 0
    @Published var motivation = ""
    // var methodologyGoal: MethodologyGoal
    
//    init(methodologyGoal: MethodologyGoal) {
//        self.methodologyGoal = methodologyGoal
//    }
    
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
        goals.replaceSubrange( index ... index, with: [goal])
        moveCompletedGoalToEnd()
        Task.init {
            await cloud.update(model: goal)
        }
    }
    
    func moveCompletedGoalToEnd(){
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

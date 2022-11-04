//
//  HomeModelView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI
import Foundation

class HomeViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var dictionarySpent: [[Spent]] = []
    @Published var goals: [Goal] = []
    @Published var spentsCards: [SpentsCard] = []
    var methodologyGoals: MethodologyGoal?
}

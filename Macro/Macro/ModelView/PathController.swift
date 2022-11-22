//
//  PathController.swift
//  Macro
//
//  Created by Vitor Cheung on 21/11/22.
//
import SwiftUI
import Foundation
class PathController: ObservableObject {
    @Published var path = NavigationPath()
    
    @ViewBuilder
    func pushPath(destination: EnumViewNames) -> some View {
        switch destination {
        case .settingsView:
            SettingsView()
        case .methodologySpentsView:
            MethodologySpentsView()
        case .methodologyGoalsView:
            MethodologyGoalsView()
        case .formsGoalsNameView:
            FormsGoalsNameView()
        case .formsGoalsValueView:
            FormsGoalsValueView()
        case .formsGoalsMotivationView:
            FormsGoalMotivationView()
        }
    }
}
enum EnumViewNames {
    case settingsView
    case methodologySpentsView
    case methodologyGoalsView
    case formsGoalsNameView
    case formsGoalsValueView
    case formsGoalsMotivationView
}

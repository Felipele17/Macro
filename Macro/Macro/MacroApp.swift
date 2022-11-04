//
//  MacroApp.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI
@main
struct MacroApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) private var scenePhase
    @StateObject var viewModel = MacroViewModel()
    
    let userDefault = UserDefault()
    
    var body: some Scene {
        WindowGroup {
            if userDefault.userOnBoardingBool {
                if viewModel.isConect {
                    if viewModel.isReady() {
                        if let methodologyGoals = viewModel.methodologyGoals {
                            HomeView(users: viewModel.users, dictionarySpent: viewModel.dictionarySpent, goals: viewModel.goals, spentsCards: viewModel.getSpentsCards(), methodologyGoals: methodologyGoals)
                        }
                    } else {
                        LaunchScreenView()
                    }
                } else {
                    NoNetView()
                }
            } else {
                OnBoardingView(incomeTextField: userDefault.userOnBoardingIncome == 0.0 ? "" : String(userDefault.userOnBoardingIncome))
            }
        }
        .onChange(of: scenePhase) { (newScenePhase) in
                   switch newScenePhase {
                   case .active:
                       Task {
                           CloudKitModel.shared.share = try await CloudKitModel.shared.fetchShare()
                           let isSendInviteAccepted = await CloudKitModel.shared.isSendInviteAccepted()
                          DispatchQueue.main.async {
                              Invite.shared.isSendInviteAccepted = isSendInviteAccepted
                          }
                       }
                   case .inactive:
                       print("ffff")
//                       print("scene is now inactive!")
                   case .background:
                       print("ffff")
//                       print("scene is now in the background!")
                   @unknown default:
                       print("")
//                       print("Apple must have added something new!")
                   }
               }
    }
}

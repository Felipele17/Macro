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
    var observableDataBase = ObservableDataBase.shared
    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.bool(forKey: "didOnBoardingHappen") {
                if viewModel.isConect {
                    if viewModel.isReady() {
                        if let methodologyGoals = viewModel.methodologyGoals {
                            HomeView(users: $viewModel.users, dictionarySpent: $viewModel.dictionarySpent, goals: $viewModel.goals, spentsCards: $viewModel.spentsCards, methodologyGoals: methodologyGoals)
                                .onChange(of: observableDataBase.needFetchSpent) { _ in
                                    viewModel.reload(type: Spent.getType())
                                    observableDataBase.needFetchSpent = false
                                }
                                .onChange(of: observableDataBase.needFetchGoal) { _ in
                                    viewModel.reload(type: Goal.getType())
                                    observableDataBase.needFetchGoal = false
                                }
                        }
                    } else {
                        LaunchScreenView()
                    }
                } else {
                    NoNetView()
                }
            } else {
                OnBoardingView(incomeTextField: UserDefaults.standard.float(forKey: "income"))
            }
        }
        .onChange(of: scenePhase) { (newScenePhase) in
                   switch newScenePhase {
                   case .active:
                       if !Invite.shared.isSendInviteAccepted {
                           Task {
                               CloudKitModel.shared.share = try await CloudKitModel.shared.fetchShare()
                               let isSendInviteAccepted = await CloudKitModel.shared.isSendInviteAccepted()
                               DispatchQueue.main.async {
                                   Invite.shared.isSendInviteAccepted = isSendInviteAccepted
                               }
                           }
                       }
                   case .inactive:
                       print("scene is now inactive!")
                   case .background:
                       print("scene is now in the background!")
                   @unknown default:
                       print("Apple must have added something new!")
                   }
               }
    }
}

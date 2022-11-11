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
    @StateObject var spentViewModel = SpentViewModel()
    @StateObject var goalViewModel = GoalViewModel()
    @StateObject var observableDataBase = ObservableDataBase.shared
    @StateObject var settingsViewModel = SettingsViewModel()
    let userDefault = UserDefault()
    
    var body: some Scene {
        WindowGroup {
            if userDefault.userOnBoardingBool {
                if viewModel.isConect {
                    if viewModel.isReady() {
                        HomeView()
                            .environmentObject(goalViewModel)
                            .environmentObject(spentViewModel)
                            .environmentObject(viewModel)
                            .environmentObject(settingsViewModel)
                            .onAppear {
                                spentViewModel.dictionarySpent = viewModel.dictionarySpent
                                spentViewModel.spentsCards = viewModel.spentsCards
                                goalViewModel.goals = viewModel.goals
                                goalViewModel.methodologyGoals = viewModel.methodologyGoals
                            }
                            .onReceive(viewModel.$dictionarySpent, perform: { dictionarySpent in
                                spentViewModel.dictionarySpent = dictionarySpent
                            })
                            .onReceive(viewModel.$goals, perform: { goals in
                                goalViewModel.goals = goals
                            })
                            .onChange(of: observableDataBase.needFetchSpent) { _ in
                                    viewModel.reload(type: Spent.getType())
                                    observableDataBase.needFetchSpent = false
                            }
                            .onChange(of: observableDataBase.needFetchGoal) { _ in
                                    viewModel.reload(type: Goal.getType())
                                    observableDataBase.needFetchGoal = false
                            }
                    } else {
                        LaunchScreenView()
                    }
                } else {
                    NoNetView()
                }
            } else {
                OnBoardingView(incomeTextField: userDefault.userFloatIncome == 0.0 ? "" : String(userDefault.userFloatIncome).replacingOccurrences(of: ".", with: ","))
            }
        }
        .onChange(of: scenePhase) { (newScenePhase) in
                   switch newScenePhase {
                   case .active:
                       if !Invite.shared.isSendInviteAccepted {
                           Task {
                               CloudKitModel.shared.share = try await CloudKitModel.shared.fetchShare(database: .dataPrivate)
                               let isSendInviteAccepted = await CloudKitModel.shared.isSendInviteAccepted()
                               DispatchQueue.main.async {
                                   Invite.shared.isSendInviteAccepted = isSendInviteAccepted
                               }
                           }
                       }
                   case .inactive:
                       print("")
//                       print("scene is now inactive!")
                   case .background:
                       print("")
//                       print("scene is now in the background!")
                   @unknown default:
                       print("")
//                       print("Apple must have added something new!")
                   }
               }
    }
}

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
    @StateObject var onboardingViewModel = OnBoardingViewModel()
    @StateObject var observableDataBase = ObservableDataBase.shared
    @StateObject var settingsViewModel = SettingsViewModel()
    @StateObject var invite = Invite.shared
    let userDefault = UserDefault()
    
    var body: some Scene {
        WindowGroup {
            if viewModel.isConect {
                    if viewModel.isFinishedLoad {
                        if onboardingViewModel.onboardingFinished {
                        HomeView()
                            .environmentObject(goalViewModel)
                            .environmentObject(spentViewModel)
                            .environmentObject(viewModel)
                            .environmentObject(settingsViewModel)
                            .onAppear {
                                spentViewModel.dictionarySpent = viewModel.matrixSpent
                                spentViewModel.spentsCards = viewModel.spentsCards
                                goalViewModel.goals = viewModel.goals
                                goalViewModel.methodologyGoals = viewModel.methodologyGoals
                            }
                            .onReceive(viewModel.$matrixSpent, perform: { matrixSpent in
                                spentViewModel.dictionarySpent = matrixSpent
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
                            OnBoardingView(incomeTextField: userDefault.userFloatIncome == 0.0 ? "" : String(userDefault.userFloatIncome).replacingOccurrences(of: ".", with: ","))
                                .environmentObject(onboardingViewModel)
                                .environmentObject(invite)
                        }
                    } else {
                        LaunchScreenView()
                            .onChange(of: invite.isSendInviteAccepted) { _ in
                                onboardingViewModel.checkOnboardingFinished()
                            }
                            .onChange(of: invite.isReceivedInviteAccepted) { _ in
                                onboardingViewModel.checkOnboardingFinished()
                            }
                    }
            } else {
                NoNetView()
            }

        }
        .onChange(of: scenePhase) { (newScenePhase) in
                   switch newScenePhase {
                   case .active:
                       print("")
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

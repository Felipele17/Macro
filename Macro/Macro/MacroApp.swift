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
    @StateObject var pathController = PathController()
    @StateObject var onboardingViewModel = OnBoardingViewModel()
    @StateObject var observableDataBase = ObservableDataBase.shared
    @StateObject var settingsViewModel = SettingsViewModel()
    @StateObject var invite = Invite.shared
    let userDefault = UserDefault()
    
    var body: some Scene {
        WindowGroup {
            if viewModel.isConect {
                    if viewModel.isFinishedLoad {
                        if onboardingViewModel.onboardingFinished && UserDefault.getFistPost() {
                        HomeView()
                            .environmentObject(goalViewModel)
                            .environmentObject(spentViewModel)
                            .environmentObject(viewModel)
                            .environmentObject(pathController)
                            .environmentObject(settingsViewModel)
                            .environmentObject(observableDataBase)
                            .onAppear {
                                spentViewModel.dictionarySpent = viewModel.matrixSpent
                                spentViewModel.spentsCards = viewModel.spentsCards
                                goalViewModel.goals = viewModel.goals
                                goalViewModel.setMethodologyGoals(methodologyGoals: viewModel.methodologyGoals)
                            }
                            .onReceive(viewModel.$users, perform: { users in
                                settingsViewModel.users = users
                            })
                            .onReceive(viewModel.$matrixSpent, perform: { matrixSpent in
                                spentViewModel.dictionarySpent = matrixSpent
                                spentViewModel.updateDateSpentsCards()
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
                            .onChange(of: invite.isSendInviteAccepted) { _ in
                                onboardingViewModel.checkOnboardingFinished()
                            }
                            .onChange(of: invite.isReceivedInviteAccepted) { _ in
                                onboardingViewModel.checkOnboardingFinished()
                            }
                        } else {
                            OnBoardingView()
                                .environmentObject(onboardingViewModel)
                                .environmentObject(settingsViewModel)
                                .environmentObject(invite)
                                .onReceive(onboardingViewModel.$onboardingFinished, perform: { _ in
                                    let spentsCards = onboardingViewModel.crateSpentCards(income: userDefault.userFloatIncome)
                                    settingsViewModel.users = onboardingViewModel.users
                                    spentViewModel.spentsCards = spentsCards
                                    spentViewModel.dictionarySpent = [[], [], []]
                                    goalViewModel.setMethodologyGoals(methodologyGoals: onboardingViewModel.methodologyGoal)
                                    
                                    viewModel.users = onboardingViewModel.users
                                    viewModel.methodologyGoals = onboardingViewModel.methodologyGoal
                                    viewModel.methodologySpent = onboardingViewModel.methodologySpent
                                    viewModel.matrixSpent = spentViewModel.dictionarySpent
                                    viewModel.spentsCards = spentViewModel.spentsCards
                                    viewModel.goals = goalViewModel.goals
                                })
                                .onAppear {
                                    Task {
                                        viewModel.cloud.share = try await viewModel.cloud.getShare()
                                        Task {
                                            await invite.checkSendAccepted(share: viewModel.cloud.share)
                                        }
                                        Task {
                                            await invite.checkReceivedAccepted()
                                        }
                                    }
                                    UserDefault.setFistPost(isFistPost: false)
                                }
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
    }
}

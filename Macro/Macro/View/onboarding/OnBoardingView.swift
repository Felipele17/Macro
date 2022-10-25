//
//  OnBoardingView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct OnBoardingView: View {
    @State var incomeTextField: Float
    @State var text = EnumButtonText.nextButton.rawValue
    @StateObject var viewModel = OnBoardingViewModel()
    @StateObject var invite = Invite.shared
    @State private var pages: [OnBoarding] = OnBoarding.onboardingPages
    private let dotAppearance = UIPageControl.appearance()
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                TabView(selection: $viewModel.onboardingPage) {
                    OnBoardingPageTypeOneView(onboarding: pages[0])
                        .tag(0)
                    OnBoardingPageTypeOneView(onboarding: pages[1])
                        .tag(1)
                    OnBoardingPageTypeTwoView(onboarding: pages[2], viewModel: viewModel, incomeTextField: $incomeTextField)
                        .tag(2)
                        .gesture(incomeTextField == 0.0 ? DragGesture() : nil)
                    if invite.isSendInviteAccepted && invite.isReceivedInviteAccepted {
                        OnBoardingPageTypeOneView(onboarding: pages[6])
                            .tag(3)
                    } else if invite.isSendInviteAccepted {
                        OnBoardingPageTypeOneView(onboarding: pages[4])
                            .tag(3)
                    } else if invite.isReceivedInviteAccepted {
                        OnBoardingPageTypeOneView(onboarding: pages[5])
                            .tag(3)
                    } else {
                        OnBoardingPageTypeOneView(onboarding: pages[3])
                            .tag(3)
                    }
                }
                .animation(.easeInOut, value: viewModel.onboardingPage)
                .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                .tabViewStyle(.page)
                .onAppear {
                    dotAppearance.currentPageIndicatorTintColor = UIColor(Color(EnumColors.dotAppearing.rawValue))
                    dotAppearance.pageIndicatorTintColor = UIColor(Color(EnumColors.dotNotAppearing.rawValue))
                }
                if invite.isReady(income: incomeTextField) {
//                    NavigationLink {
//                        HomeView(users: <#[User]#>, dictionarySpent: <#[[Spent]]#>, goals: <#[Goal]#>, spentsCards: <#[SpentsCard]#>, methodologyGoals: <#MethodologyGoal#>)
//                    } label: {
//                        Text("Concluir")
//                            .font(.headline)
//                            .foregroundColor(.white)
//                            .frame(height: 55)
//                            .frame(maxWidth: .infinity)
//                            .background(Color(EnumColors.buttonColor.rawValue))
//                            .cornerRadius(13)
//                    }

                } else {
                    NextButton(text: viewModel.checkButton(), onboardingPage: $viewModel.onboardingPage, income: $incomeTextField)
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if viewModel.onboardingPage < 2 {
                        SkipButton(onboardingPage: $viewModel.onboardingPage, skipButton: EnumButtonText.skip.rawValue)
                    } else if viewModel.onboardingPage == 2 {
//                        InfoButton(infoButton: "info.circle")
//                            .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                    }
                }
                
            }
            .padding(24)
        }.accentColor(Color(EnumColors.buttonColor.rawValue))
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
    
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView(incomeTextField: UserDefaults.standard.float(forKey: "income"))
    }
}

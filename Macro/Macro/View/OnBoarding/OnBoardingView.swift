//
//  OnBoardingView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct OnBoardingView: View {
    @State var incomeTextField: String
    @State var text = EnumButtonText.nextButton.rawValue
    @StateObject var onboardingViewModel = OnBoardingViewModel()
    @StateObject var invite = Invite.shared
    @State var validTextField = false
    @State private var pages: [OnBoarding] = OnBoarding.onboardingPages
    private let dotAppearance = UIPageControl.appearance()
    
    var body: some View {
        
        NavigationView {
            VStack {
                TabView(selection: $onboardingViewModel.onboardingPage) {
                    OnBoardingPageTypeOneView(onboarding: pages[0])
                        .tag(0)
                    OnBoardingPageTypeOneView(onboarding: pages[1])
                        .tag(1)
                    OnBoardingPageTypeTwoView(onboarding: pages[2], viewModel: onboardingViewModel, value: $incomeTextField, validTextField: $validTextField)
                        .tag(2)
                        .gesture(incomeTextField.isEmpty ? DragGesture() : nil)
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
                .animation(.easeInOut, value: onboardingViewModel.onboardingPage)
                .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                .tabViewStyle(.page)
                .onAppear {
                    dotAppearance.currentPageIndicatorTintColor = UIColor(Color(EnumColors.dotAppearing.rawValue))
                    dotAppearance.pageIndicatorTintColor = UIColor(Color(EnumColors.dotNotAppearing.rawValue))
                }
                if invite.isReady(income: incomeTextField.floatValue) {
                    NextButton(text: onboardingViewModel.checkButton(), validTextField: $validTextField, onboardingPage: $onboardingViewModel.onboardingPage, income: $incomeTextField)
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if onboardingViewModel.onboardingPage < 2 {
                        SkipButton(onboardingPage: $onboardingViewModel.onboardingPage, skipButton: EnumButtonText.skip.rawValue)
                    } else if onboardingViewModel.onboardingPage == 2 {
                        InfoButton(infoButton: "info.circle")
                            .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                    }
                }
                
            }
            .padding(24)
        }.accentColor(Color(EnumColors.buttonColor.rawValue))
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

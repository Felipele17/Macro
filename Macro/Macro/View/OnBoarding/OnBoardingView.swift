//
//  OnBoardingView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct OnBoardingView: View {
    @EnvironmentObject var vm: OnBoardingViewModel
    @StateObject var invite = Invite.shared
    @State var incomeTextField: String
    @State var text = EnumButtonText.nextButton.rawValue
    @State var validTextField = false
    @State private var pages: [OnBoarding] = OnBoarding.onboardingPages
    private let dotAppearance = UIPageControl.appearance()
    
    var body: some View {
        
        NavigationView {
            VStack {
                TabView(selection: $vm.onboardingPage) {
                    OnBoardingPageTypeOneView(onboarding: pages[0])
                        .tag(0)
                    OnBoardingPageTypeOneView(onboarding: pages[1])
                        .tag(1)
                    OnBoardingPageTypeTwoView(onboarding: pages[2], value: $incomeTextField, validTextField: $validTextField)
                        .tag(2)
                        .gesture(incomeTextField.isEmpty ? DragGesture() : nil)
                    if Invite.shared.isSendInviteAccepted && Invite.shared.isReceivedInviteAccepted {
                        OnBoardingPageTypeOneView(onboarding: pages[6])
                            .tag(3)
                    } else if Invite.shared.isSendInviteAccepted {
                        OnBoardingPageTypeOneView(onboarding: pages[4])
                            .tag(3)
                    } else if Invite.shared.isReceivedInviteAccepted {
                        OnBoardingPageTypeOneView(onboarding: pages[5])
                            .tag(3)
                    } else {
                        OnBoardingPageTypeOneView(onboarding: pages[3])
                            .tag(3)
                    }
                }
                .animation(.easeInOut, value: vm.onboardingPage)
                .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                .tabViewStyle(.page)
                .onAppear {
                    dotAppearance.currentPageIndicatorTintColor = UIColor(Color(EnumColors.dotAppearing.rawValue))
                    dotAppearance.pageIndicatorTintColor = UIColor(Color(EnumColors.dotNotAppearing.rawValue))
                    validTextField = incomeTextField.isEmpty ? false : true
                }
                Button {
                    if vm.onboardingPage != 3 {
                        vm.onboardingPage += 1
                        if !incomeTextField.isEmpty {
                            let money = incomeTextField.floatValue
                            UserDefault.userNextButton(income: money)
                        }
                    } else {
                        if invite.isReady() {
                            let money = incomeTextField.floatValue
                            vm.initialPosts(income: money)
                        } else {
                            vm.sharingInvite()
                        }
                    }
                    
                } label: {
                    Text(text)
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background((validTextField && vm.onboardingPage == 2) || vm.onboardingPage != 2 ?   Color(EnumColors.buttonColor.rawValue): .gray )
                        .cornerRadius(13)
                }
                .disabled(!validTextField && vm.onboardingPage == 2)
                
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if vm.onboardingPage < 2 {
                        SkipButton(onboardingPage: $vm.onboardingPage, skipButton: EnumButtonText.skip.rawValue)
                    } else if vm.onboardingPage == 2 {
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

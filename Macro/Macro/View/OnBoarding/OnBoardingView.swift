//
//  OnBoardingView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct OnBoardingView: View {
    @EnvironmentObject var viewModel: OnBoardingViewModel
    @EnvironmentObject var invite: Invite
    @StateObject var cloud = CloudKitModel.shared
    @State var incomeTextField: String
    @State var validTextField = false
    @State var showingAlert = false
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
                    OnBoardingPageTypeTwoView(onboarding: pages[2], value: $incomeTextField, validTextField: $validTextField)
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
                .animation(.easeInOut, value: viewModel.onboardingPage)
                .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                .tabViewStyle(.page)
                Button {
                    if viewModel.onboardingPage != 3 {
                        viewModel.onboardingPage += 1
                        if !incomeTextField.isEmpty {
                            let money = incomeTextField.replacingOccurrences(of: ".", with: "").floatValue
                            UserDefault.setIncome(income: money)
                        }
                    } else {
                        if Invite.shared.isReady() {
                            let money = UserDefault.getIncome()
                            viewModel.initialPosts(income: money)
                            viewModel.onboardingFinished = true
                        } else {
                            viewModel.sharingInvite()
                        }
                    }
                    
                } label: {
                    Text(viewModel.onboardingPage == 3 && !(invite.isSendInviteAccepted && invite.isReceivedInviteAccepted ) ? (cloud.isShareNil ? "Carregando..." : "Compatilhar") : EnumButtonText.nextButton.rawValue)
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background((validTextField && viewModel.onboardingPage == 2) || viewModel.onboardingPage != 2 ?   Color(EnumColors.buttonColor.rawValue): .gray )
                        .cornerRadius(13)
                }
                .disabled(!validTextField && viewModel.onboardingPage == 2)
                
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if viewModel.onboardingPage < 2 {
                        SkipButton(onboardingPage: $viewModel.onboardingPage, skipButton: EnumButtonText.skip.rawValue)
                    } else if viewModel.onboardingPage == 2 {
                        InfoButton(infoButton: "info.circle")
                            .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                    } else if viewModel.onboardingPage == 3 {
                        Button {
                            showingAlert.toggle()
                        } label: {
                            Text("Deletar")
                        }
                        .alert("Deseja deletar o compartilhamento?", isPresented: $showingAlert) {
                            Button(role: .cancel) { }
                            label: {
                                Text("Não")
                            }
                            Button("Sim") {
                                viewModel.deleteShare()
                            }
                        }

                    }
                }
                
            }
            .padding(24)
        }.accentColor(Color(EnumColors.buttonColor.rawValue))
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            dotAppearance.currentPageIndicatorTintColor = UIColor(Color(EnumColors.dotAppearing.rawValue))
            dotAppearance.pageIndicatorTintColor = UIColor(Color(EnumColors.dotNotAppearing.rawValue))
            validTextField = incomeTextField.isEmpty ? false : true
        }
    }
}

//
//  OnBoardingView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct OnBoardingView: View {
    @State var incomeTextField: Float = 0.0
    @State var text = ButtonText.nextButton.rawValue
    @StateObject var viewModel = OnBoardingStateViewModel()
    
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
                    OnBoardingPageTypeOneView(onboarding: pages[3])
                        .tag(3)

//                    ForEach(pages) { page in
//                        VStack {
//                            ImageView(onboarding: page, viewModel: viewModel)
//                                .onAppear {
//                                    if let viewPageTextField = page as? OnBoardingPageTypeTwoView {
//                                        viewModel.checkTextField = viewPageTextField.income
//                                    }
//                                }
//                            Spacer()
//                        }
//                        .tag(page.tag)
//                    }
                }
                .animation(.easeInOut, value: viewModel.onboardingPage)
                .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                .tabViewStyle(PageTabViewStyle())
                .onAppear {
                    dotAppearance.currentPageIndicatorTintColor = UIColor(Color("dotShowing"))
                    dotAppearance.pageIndicatorTintColor = UIColor(Color("dotNotShowing"))
                }
                
                NextButton(text: viewModel.checkButton(), onboardingPage: $viewModel.onboardingPage, income: $incomeTextField)
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if viewModel.onboardingPage < 2 {
                        SkipButton(onboardingPage: $viewModel.onboardingPage, skipButton: ButtonText.skip.rawValue)
                    } else if viewModel.onboardingPage == 2 {
                        InfoButton(infoButton: "info.circle")
                    }
                }
                
            }
            .padding(24)
            .background(Color("onboardingBackground"))
        }
        
    }
    
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}

//
//  OnBoardingView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct OnBoardingView: View {
    @State var incomeTextField: Float = 0.0
    @State var text = EnumButtonText.nextButton.rawValue
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
                }
                .animation(.easeInOut, value: viewModel.onboardingPage)
                .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                .tabViewStyle(PageTabViewStyle())
                .onAppear {
                    dotAppearance.currentPageIndicatorTintColor = UIColor(.gray)
                    dotAppearance.pageIndicatorTintColor = UIColor(Color(.darkGray))
                }
                
                NextButton(text: viewModel.checkButton(), onboardingPage: $viewModel.onboardingPage, income: $incomeTextField)
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if viewModel.onboardingPage < 2 {
                        SkipButton(onboardingPage: $viewModel.onboardingPage, skipButton: EnumButtonText.skip.rawValue)
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

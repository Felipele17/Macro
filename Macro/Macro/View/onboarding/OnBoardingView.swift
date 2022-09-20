//
//  OnBoardingView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct OnBoardingView: View {
    @State var onboardingPage: Int = 0
    @ObservedObject private var viewModel = OnBoardingStateModelView()
    private let dotAppearance = UIPageControl.appearance()
    var textButton: String = ButtonText.nextButton.rawValue
    
    var body: some View {
        
        NavigationView {
            VStack {
                TabView(selection: $onboardingPage) {
                    ForEach(viewModel.pages) { page in
                        VStack {
                            ImageView(onboarding: page)
                            Spacer()
                        }
                        .tag(page.tag)
                    }
                }
                .animation(.easeInOut, value: onboardingPage)
                .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                .tabViewStyle(PageTabViewStyle())
                .onAppear {
                    dotAppearance.currentPageIndicatorTintColor = UIColor(Color("dotShowing"))
                    dotAppearance.pageIndicatorTintColor = UIColor(Color("dotNotShowing"))
                }
                viewModel.buttonOnBoarding(onboardingPage: onboardingPage) {
                    onboardingPage += 1
                } actionCompartilhar: {
                    print("compartilhar")
                    viewModel.finishOnBoarding()
                }
                
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if onboardingPage < 2 {
                        SkipButton(onboardingPage: $viewModel.onboardingPage, string: ButtonText.skip.rawValue)
                    } else if onboardingPage == 2 {
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

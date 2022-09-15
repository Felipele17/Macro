//
//  OnBoardingView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct OnBoardingView: View {
    
    @State private var onboardingPage: Int = 0
    private let pages: [OnBoarding] = OnBoarding.onboardingPages
    private let dotAppearance = UIPageControl.appearance()
    
    var textButton: String = ButtonText.nextButton.rawValue
   
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                SkipButton(skipButton: ButtonText.skip.rawValue)
            }
            Group {
                TabView(selection: $onboardingPage) {
                    ForEach(pages) { page in
                        VStack {
                            Spacer()
                            ImageView(onboarding: page)
                            Spacer()
                            if page == pages.last {
                                
                                NextButton(actionButton: {
                                    print("share button pressed")
                                }, textButton: ButtonText.shareButton.rawValue)
                            } else {
                                
                                NextButton(actionButton: {
                                    incrementPage()
                                    print("next button pressed")
                                }, textButton: textButton)
                            }
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
            }
        }
        .padding(24)
        .background(Color("onboardingBackground"))
    }
    
    func incrementPage() {
        onboardingPage += 1
    }

}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}

//
//  OnBoardingPageTypeOneView.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 21/09/22.
//

import SwiftUI

struct OnBoardingPageTypeOneView: View {
    
    let onboarding: OnBoarding
    @EnvironmentObject var viewModel: OnBoardingViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            if onboarding.tag != 7 {
                Image(self.onboarding.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                OnboardingLottie(name: "onboardingFlow", loopMode: .loop)
                    .padding(.bottom, 20)
            }
            
            Text(onboarding.title)
                .font(.custom(EnumFonts.bold.rawValue, size: 22))
                .padding(.bottom, viewModel.onboardingPage == 4 ?  5 : 0)
                .multilineTextAlignment(.center)
                .padding(1.1)
            
            Text(onboarding.description)
                .multilineTextAlignment(.center)
                .padding(.bottom, viewModel.onboardingPage == 4 ?  5 : 0)
                .font(.custom(EnumFonts.regular.rawValue, fixedSize: 16))
            
            Spacer()
        }
        .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenHeight/1.5)
    }
}

struct OnBoardingPageTypeOneView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingPageTypeOneView(onboarding: OnBoarding(imageName: "noz", title: "Título", description: "texto descritivo", tag: 0))
    }
}

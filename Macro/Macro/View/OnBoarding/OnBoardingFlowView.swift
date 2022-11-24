//
//  OnBoardingFlowView.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 24/11/22.
//

import SwiftUI

struct OnBoardingFlowView: View {
    var body: some View {
        VStack {
            Text("Como funciona?")
                .font(.custom(EnumFonts.bold.rawValue, size: 22))
                .padding(.bottom, 10)
            OnboardingLottie(name: "onboardingFlow", loopMode: .loop)
        }
    }
}

struct OnBoardingFlowView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingFlowView()
    }
}

//
//  OnBoardingFlowView.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 24/11/22.
//

import SwiftUI

struct OnBoardingFlowView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Como funciona?")
                .font(.custom(EnumFonts.bold.rawValue, size: 22))
            OnboardingLottie(name: "onboardingFlow", loopMode: .loop)
                
            VStack(alignment: .leading) {
                Text("Ao enviar o convite ao seu parceiro, você deve esperar ele/a baixe o App e também te envie um convite. Assim que ambos receberem, podem começar a usar!")
                    
            }.padding(.bottom, 80)
        }
        .padding(20)
    }
}

struct OnBoardingFlowView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingFlowView()
    }
}

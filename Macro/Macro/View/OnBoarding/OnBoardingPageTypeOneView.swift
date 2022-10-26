//
//  OnBoardingPageTypeOneView.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 21/09/22.
//

import SwiftUI

struct OnBoardingPageTypeOneView: View {
    
    let onboarding: OnBoarding
    
    var body: some View {
        VStack(alignment: .center) {
            Image(self.onboarding.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text(onboarding.title)
                .font(.custom("SF Pro Text", size: 22))
                .multilineTextAlignment(.center)
                .padding(1.1)
            
            Text(onboarding.description)
                .multilineTextAlignment(.center)
                .font(.custom("SF Pro Text", fixedSize: 16))
            
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

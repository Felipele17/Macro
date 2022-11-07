//
//  OnBoardingPageTypeTwoView.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 21/09/22.
//

import SwiftUI

struct OnBoardingPageTypeTwoView: View {
    
    let onboarding: OnBoarding
    @EnvironmentObject var viewModel: OnBoardingViewModel
    @Binding var value: String
    @Binding var validTextField: Bool
    @FocusState private var keyboardIsFocused: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Text(onboarding.title)
                .font(.custom(EnumFonts.semibold.rawValue, fixedSize: 26))
            Text(onboarding.description)
                .font(.custom(EnumFonts.medium.rawValue, fixedSize: 16))
                .padding(1.3)
            
            VStack {
                TextField("Ex.: R$ 3000,00", text: $value)
                    .keyboardType(.decimalPad)
                    .foregroundColor(Color(EnumColors.subtitle.rawValue))
                    .focused($keyboardIsFocused)
                Rectangle()
                    .frame(height: 1.0, alignment: .bottom)
                    .foregroundColor(Color(EnumColors.subtitle.rawValue))
                    .onChange(of: value) { _ in
                        if value.transformToMoney() != nil {
                            validTextField = true
                        } else {
                            validTextField = false
                        }
                    }
                    
            }
            .padding(1.5)
            Spacer()
            HStack {
                Spacer()
                Image(self.onboarding.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.screenWidth * 0.7)
                    .clipped()
                Spacer()
            }
            Spacer()
        }
        .onReceive(viewModel.$onboardingPage, perform: { _ in
            keyboardIsFocused = false
        })
        
        .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenHeight/1.6)
    }
}

// struct OnBoardingPageTypeTwoView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        OnBoardingPageTypeTwoView(onboarding: OnBoarding(imageName: EnumImageName.doubleSquirrels.rawValue, title: "title", description: "description", tag: 0), viewModel: OnBoardingViewModel(), value: .constant("50"), validTextField: .constant(true))
//    }
// }

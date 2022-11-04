//
//  OnBoardingPageTypeTwoView.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 21/09/22.
//

import SwiftUI

struct OnBoardingPageTypeTwoView: View {
    
    let onboarding: OnBoarding
    @ObservedObject var viewModel: OnBoardingViewModel
    @Binding var incomeTextField: Float
//    @State var income: Bool
    @FocusState var keyboardIsFocused: Bool
    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
        formatter.zeroSymbol = ""
            return formatter
        }()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(onboarding.title)
                .font(.custom("SFProText-Semibold", fixedSize: 26))
            Text(onboarding.description)
                .font(.custom("SFProText-Medium", fixedSize: 16))
                .padding(1.3)
            
            VStack {
                TextField("Ex.: R$ 3000,00", value: $incomeTextField, formatter: formatter)
                    .keyboardType(.decimalPad)
                    .foregroundColor(Color(EnumColors.subtitle.rawValue))
                    .focused($keyboardIsFocused)
                Rectangle()
                    .frame(height: 1.0, alignment: .bottom)
                    .foregroundColor(Color(EnumColors.subtitle.rawValue))
                    
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
//    static var previews: some View {
//        OnBoardingPageTypeTwoView(onboarding: OnBoarding(imageName: "esquilo", title: "Título", description: "texto de descrição", tag: 2), viewModel: OnBoardingViewModel(), incomeTextField: .constant(10))
//    }
// }

//
//  ImageView.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 14/09/22.
//

import SwiftUI

struct ImageView: View {
    
    let onboarding: OnBoarding
    @State private var incomeTextField: Int?
    
    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()
    
    var body: some View {
        
        if onboarding.tag != 2 {
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
        } else { // textfield renda mensal
            VStack(alignment: .leading) {
                Text(onboarding.title)
                    .fontWeight(.bold)
                    .font(.custom("SF Pro Text", fixedSize: 26))
                Text(onboarding.description)
                    .font(.custom("SF Pro Text", fixedSize: 16))
                    .padding(1.1)
                
                VStack {
                    TextField("Ex.: R$ 3000,00", value: $incomeTextField, formatter: formatter)
                        .keyboardType(.decimalPad)
                        .foregroundColor(Color("Placeholder"))
                    Rectangle()
                        .frame(height: 1.0, alignment: .bottom)
                        .foregroundColor(Color("Placeholder"))
                        
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
            .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenHeight/1.6)
        }
        
    }
    
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(onboarding: OnBoarding(imageName: "esquilo", title: "título", description: "descrição", tag: 2))
    }
}

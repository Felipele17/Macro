//
//  NextButton.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 21/09/22.
//

import SwiftUI

struct NextButton: View {
    
    var text: String
    @Binding var onboardingPage: Int
    @Binding var income: Float?
    
    var body: some View {
        Button {
            if onboardingPage != 3 {
                onboardingPage += 1
            }
            print(income)
            
        } label: {
            Text(text)
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(income != 0.0 ? Color("Button") : Color("Placeholder"))
                .cornerRadius(13)
        }
    }
}

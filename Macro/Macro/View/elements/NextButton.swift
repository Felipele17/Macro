//
//  NextButton.swift
//  Macro
//
//  Created by Vitor Cheung on 23/09/22.
//

import Foundation
import SwiftUI

struct NextButton: View {
    
    var text: String
    @Binding var onboardingPage: Int
    @Binding var income: Float
    
    var body: some View {
        Button {
            if onboardingPage != 3 {
                onboardingPage += 1
            }
            
        } label: {
            Text(text)
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(income != 0.0 ? .blue : Color(EnumColors.ButtonColor.rawValue))
                .cornerRadius(13)
        }
    }
}

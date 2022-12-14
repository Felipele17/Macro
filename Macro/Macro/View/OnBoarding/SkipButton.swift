//
//  SkipButton.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 26/09/22.
//

import SwiftUI

struct SkipButton: View {
    var skipButton: String
    @Binding var onboardingPage: Int
    
    init(onboardingPage: Binding<Int>, skipButton: String) {
        self._onboardingPage = onboardingPage
        self.skipButton = skipButton
    }
    
    var body: some View {
        Button {
            print("skip button")
            onboardingPage = 2
        } label: {
            Text(skipButton)
                .font(.custom(EnumFonts.regular.rawValue, fixedSize: 17))
                .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                .padding(16)
        }

    }
}

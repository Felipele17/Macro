//
//  Button.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 14/09/22.
//

import Foundation
import SwiftUI

struct NextButton: View {
    
    var actionButton: ()-> Void
    var textButton: String
    @State var onboardingPage: Int = 0
    
    var body: some View {
        Button {
            actionButton()
        } label: {
            Text(textButton)
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color("button"))
                .cornerRadius(13)
        }

    }
}

struct SkipButton: View {
    var skipButton: String
    
    var body: some View {
        Button {
            print("skip view")
        } label: {
            Text(skipButton)
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(16)
        }

    }
}

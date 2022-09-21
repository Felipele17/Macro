//
//  Button.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 14/09/22.
//

import Foundation
import SwiftUI

struct NextButton: View {
    
    var actionButton: () -> Void
    var textButton: String
    
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
                .font(.custom("SF Pro Text", fixedSize: 17))
                .foregroundColor(.gray)
                .padding(16)
        }

    }
}

struct InfoButton: View {
    var infoButton: String

    var body: some View {
        NavigationLink {
            ExpensesMethodView()
        } label: {
            Label("Informação", systemImage: infoButton)
                .tint(.blue)
                .padding(.trailing)
            .padding(.top)
        }
    }
}

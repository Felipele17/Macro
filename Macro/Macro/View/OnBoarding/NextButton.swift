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
    @ObservedObject var onboardingViewModel = OnBoardingViewModel()
    @Binding var validTextField: Bool
    @Binding var onboardingPage: Int
    @Binding var income: String
    
    var body: some View {
        Button {
            if onboardingPage != 3 {
                onboardingPage += 1
                if !income.isEmpty {
                    let money = income.floatValue
                    UserDefault.userNextButton(income: money)
                }
            } else {
                onboardingViewModel.sharingInvite()
            }
            
        } label: {
            Text(text)
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background((validTextField && onboardingPage == 2) || onboardingPage != 2 ?   Color(EnumColors.buttonColor.rawValue): .gray )
                .cornerRadius(13)
        }
        .disabled(!validTextField && onboardingPage == 2)
    
    }
}

extension UIApplication {
    
    public var keyWindow: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes
            // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
            // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
            // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
            // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
    
}

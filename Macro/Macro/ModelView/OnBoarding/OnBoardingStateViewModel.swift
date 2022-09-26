//
//  OnBoardingStateViewModel.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 26/09/22.
//

import Foundation
import SwiftUI

class OnBoardingStateViewModel: ObservableObject {
    
    @Published var onboardingState: Bool = false /// fazendo o onboarding aparecer apenas uma vez no App
    @Published var onboardingPage: Int = 0
        
    init() {
        if UserDefaults().bool(forKey: "State") {
            onboardingState = true
        } else {
            onboardingState = false
        }
    }
    
    func finishOnBoarding() {
        onboardingState = true
        UserDefaults().set(true, forKey: "State")
    }
    
    func checkButton() -> String {
        if onboardingPage == 3 {
            return EnumButtonText.shareButton.rawValue
        }
        return EnumButtonText.nextButton.rawValue
    }
    
}

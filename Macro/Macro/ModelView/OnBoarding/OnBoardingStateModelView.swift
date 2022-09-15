//
//  OnBoardingState.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 14/09/22.
//

import Foundation
import SwiftUI

// construir uma forma de fazer o onboarding aparecer apenas uma vez
class OnBoardingStateModelView: ObservableObject {
    
    @Published var onboardingState: Bool = false
    
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
}

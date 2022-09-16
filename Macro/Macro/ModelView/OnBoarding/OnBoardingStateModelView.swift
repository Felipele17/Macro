//
//  OnBoardingState.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 14/09/22.
//

import Foundation
import SwiftUI

class OnBoardingStateModelView: ObservableObject {
    
    let pages: [OnBoarding] = OnBoarding.onboardingPages
    /// fazendo o onboarding aparecer apenas uma vez no App
    @Published var onboardingState: Bool = false
    /// fazendo a lógica do botão e da view do onboarding
        
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
    
    func buttonOnBoarding( onboardingPage: Int, actionNext: @escaping ()->Void, actionCompartilhar: @escaping ()->Void) -> NextButton {
        var text = ButtonText.nextButton.rawValue
        var action = actionNext
        if onboardingPage == pages.count-1 {
            text = ButtonText.shareButton.rawValue
            action = actionCompartilhar
        }
        return NextButton(actionButton: action, textButton: text)
    }

}

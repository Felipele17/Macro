//
//  OnBoardingStateViewModel.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 26/09/22.
//

import Foundation
import CloudKit
import SwiftUI

class OnBoardingViewModel: ObservableObject {
    
    @Published var onboardingPage: Int = 0
    var cloud = CloudKitModel.shared
    
    func checkButton() -> String {
        if onboardingPage == 3 {
            return EnumButtonText.shareButton.rawValue
        }
        return EnumButtonText.nextButton.rawValue
    }

}

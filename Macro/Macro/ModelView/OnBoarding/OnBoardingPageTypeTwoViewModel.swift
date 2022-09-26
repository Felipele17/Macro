//
//  OnBoardingPageTypeTwoViewModel.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 26/09/22.
//

import SwiftUI

class OnBoardingPageTypeTwoViewModel: ObservableObject {
    @Published var onboardingPage: Int
    init(onboardingPage: Int){
        self.onboardingPage = onboardingPage
    }
}

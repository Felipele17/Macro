//
//  OnBoardingPageTypeTwoViewModel.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 22/09/22.
//

import Foundation

class OnBoardingPageTypeTwoViewModel: ObservableObject {
    @Published var onboardingPage: Int
    init(onboardingPage: Int){
        self.onboardingPage = onboardingPage
    }
}

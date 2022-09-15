//
//  OnBoarding.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 15/09/22.
//

import Foundation

struct OnBoarding: Identifiable, Hashable {
    let id = UUID()
    var imageName: String
    var title: String
    var description: String
    var tag: Int
    
    static var onboardingPages: [OnBoarding] = [
        OnBoarding(imageName: ImageName.nuts.rawValue, title: OnBoardingText.titleFirstScreen.rawValue, description: OnBoardingText.firstScreen.rawValue, tag: 0),
        OnBoarding(imageName: ImageName.squirrels.rawValue, title: OnBoardingText.titleSecondScreen.rawValue, description: OnBoardingText.secondScreen.rawValue, tag: 1),
        OnBoarding(imageName: ImageName.squirrel.rawValue, title: OnBoardingText.titleIncomeScreen.rawValue, description: OnBoardingText.incomeScreen.rawValue, tag: 2),
        OnBoarding(imageName: ImageName.invitePhone.rawValue, title: OnBoardingText.titleInviteScreen.rawValue, description: OnBoardingText.inviteScreen.rawValue, tag: 3)
    ]
}

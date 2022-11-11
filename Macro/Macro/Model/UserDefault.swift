//
//  UserDefault.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 31/10/22.
//

import Foundation
import SwiftUI

class UserDefault {

    // MARK: MacroApp
    let userOnBoardingBool = UserDefaults.standard.bool(forKey: "didOnBoardingHappen")
    let userFloatIncome = UserDefaults.standard.float(forKey: "income")

    // MARK: MacroViewModel
    static func userMacroIncome() -> Float {
            return UserDefaults.standard.float(forKey: "income")
    }
    static func userMacroSetIncome(income: Float) {
        UserDefaults.standard.set(income, forKey: "income")
    }

    // MARK: Invite
    static func userOnBoardingInvite() {
        UserDefaults.standard.setValue(true, forKey: "didOnBoardingHappen")
    }
    static func userOnBoardingUsername(username: String) {
        UserDefaults.standard.setValue(username, forKey: "username")
    }

    // MARK: NextButton (OnBoarding)
    static func userNextButton(income: Float) {
       UserDefaults.standard.setValue(income, forKey: "income")
    }
    static func userHomeViewString() -> String {
        return UserDefaults.standard.string(forKey: "username") ?? ""
    }
}

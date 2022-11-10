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
    let userOnBoardingIncome = UserDefaults.standard.float(forKey: "income")

    // MARK: MacroViewModel
    static func getIncome() -> Float {
            return UserDefaults.standard.float(forKey: "income")
    }
    static func setIncome(income: Float) {
        UserDefaults.standard.set(income, forKey: "income")
    }

    static func setUsername(username: String) {
        UserDefaults.standard.setValue(username, forKey: "username")
    }

    static func getUsername() -> String {
        return UserDefaults.standard.string(forKey: "username") ?? ""
    }
    
    // MARK: Cloud
    static func setSubscriptionShareToFalse() {
        UserDefaults.standard.setValue(false, forKey: "didCreateSubscriptioncloudkit.share")
    }
}

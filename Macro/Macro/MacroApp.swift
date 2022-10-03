//
//  MacroApp.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

@main
struct MacroApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            //OnBoardingView()
            FormsGoalsNameView()
        }
    }
}

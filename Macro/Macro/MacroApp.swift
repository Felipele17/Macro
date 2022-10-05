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
    @Environment(\.scenePhase) private var scenePhase
    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.bool(forKey: "didOnBoardingHappen") {
                HomeView()
            } else {
                OnBoardingView(incomeTextField: UserDefaults.standard.float(forKey: "income"))
            }
        }
        .onChange(of: scenePhase) { (newScenePhase) in
                   switch newScenePhase {
                   case .active:
                       Task {
                           await CloudKitModel.shared.loadShare()
                           let isSendInviteAccepted = await CloudKitModel.shared.isSendInviteAccepted()
                          DispatchQueue.main.async {
                              Invite.shared.isSendInviteAccepted = isSendInviteAccepted
                          }
                       }
                   case .inactive:
                       print("")
//                       print("scene is now inactive!")
                   case .background:
                       print("")
//                       print("scene is now in the background!")
                   @unknown default:
                       print("")
//                       print("Apple must have added something new!")
                   }
               }
    }
}

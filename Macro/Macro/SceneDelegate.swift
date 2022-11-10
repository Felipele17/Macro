//
//  SceneDelegate.swift
//  Macro
//
//  Created by Vitor Cheung on 03/10/22.
//

import UIKit
import SwiftUI
import OSLog
import CloudKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    let cloud = CloudKitModel.shared
    
    private let logger = Logger(
        subsystem: "iCloud.vitorCheung.TesteComCloud",
        category: "SceneDelegate"
    )
    
    func windowScene(  _ windowScene: UIWindowScene, userDidAcceptCloudKitShareWith cloudKitShareMetadata: CKShare.Metadata ) {
        Task {
            await cloud.accept(cloudKitShareMetadata)
            print("isReceivedInviteAccepted")
            Task {
                await Invite.shared.checkReceivedInviteAccepted()
            }
        }
    }
}

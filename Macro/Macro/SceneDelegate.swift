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
            do {
                try await cloud.accept(cloudKitShareMetadata)
            } catch {
                logger.error("\(error.localizedDescription, privacy: .public)")
            }
            print("isReceivedInviteAccepted")
             let isReceivedInviteAccepted = await cloud.isReceivedInviteAccepted()
            DispatchQueue.main.async {
                Invite.shared.isReceivedInviteAccepted = isReceivedInviteAccepted
            }
        }
    }
}

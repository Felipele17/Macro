//
//  Invite.swift
//  Macro
//
//  Created by Vitor Cheung on 04/10/22.
//

import Foundation
import CloudKit
class Invite: ObservableObject {
    
    static var shared = Invite()
    private var cloud = CloudKitModel.shared
    
    @Published var isReceivedInviteAccepted: Bool = false
    @Published var isSendInviteAccepted: Bool = false
        
     private init() {
        Task {
            await checkReceivedAccepted()
        }
    }
    
    func checkReceivedAccepted() async {
        do {
            let zone = try await cloud.getSharedZone()
            if zone != nil {
                DispatchQueue.main.async {
                    self.isReceivedInviteAccepted = true
                }
            } else {
                DispatchQueue.main.async {
                    self.isReceivedInviteAccepted = false
                }
            }
        } catch let error {
            print(error.localizedDescription)
        }
        print("checkReceivedInviteAccepted")
    }
    
    func checkSendAccepted(share: CKShare?) async {
        guard let participantes = share?.participants.count else { return }
        if participantes <= 1 {
            DispatchQueue.main.async {
                self.isSendInviteAccepted = false
            }
        } else {
            DispatchQueue.main.async {
                self.isSendInviteAccepted = true
            }
        }
        print("checkSendInviteAccepted")
    }
    
    func cleanName(name: String?) -> String? {
        guard let strings = name?.split(separator: " ", omittingEmptySubsequences: false) else {
            return nil
        }
        return String(strings[1])
    }
    
    func isReady() -> Bool {
        if isSendInviteAccepted && isReceivedInviteAccepted {
            return true
        } else {
            return false
        }
    }
}

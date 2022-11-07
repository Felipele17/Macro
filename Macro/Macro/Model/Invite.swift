//
//  Invite.swift
//  Macro
//
//  Created by Vitor Cheung on 04/10/22.
//

import Foundation
class Invite: ObservableObject {
    
    static var shared = Invite()
    private var cloud = CloudKitModel.shared
    
    @Published var isReceivedInviteAccepted: Bool = false
    @Published var isSendInviteAccepted: Bool = false
        
     init() {
        Task {
            let isReceivedInviteAccepted = await checkReceivedInviteAccepted()
            let isSendInviteAccepted = await checkSendInviteAccepted()
            DispatchQueue.main.async {
                self.isReceivedInviteAccepted = isReceivedInviteAccepted
                self.isSendInviteAccepted = isSendInviteAccepted
            }
        }
    }
    
    func checkReceivedInviteAccepted() async -> Bool {
        if (try? await cloud.getSharedZone()) != nil {
            return true
        } else {
            return false
        }
    }
    
    func checkSendInviteAccepted() async -> Bool {
        let shared = try? await cloud.getShare()
        guard let participantes = shared?.participants.count else { return false }
        if participantes <= 1 {
            return false
        } else {
            return true
        }
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

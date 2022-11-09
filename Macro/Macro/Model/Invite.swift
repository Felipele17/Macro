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
        checkReceivedInviteAccepted()
        checkSendInviteAccepted()
    }
    
    func checkReceivedInviteAccepted() {
        Task {
            if (try? await cloud.getSharedZone()) != nil {
                DispatchQueue.main.async {
                    Invite.shared.isReceivedInviteAccepted = true
                }
            } else {
                DispatchQueue.main.async {
                    Invite.shared.isReceivedInviteAccepted = false
                }
            }
        }
    }
    
    func checkSendInviteAccepted() {
        Task {
            let shared = cloud.getShare()
            guard let participantes = shared?.participants.count else { return }
            if participantes <= 1 {
                DispatchQueue.main.async {
                    Invite.shared.isSendInviteAccepted = false
                }
            } else {
                DispatchQueue.main.async {
                    Invite.shared.isSendInviteAccepted = true
                }
            }
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

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
             await checkReceivedInviteAccepted()
         }
        Task {
             await checkSendInviteAccepted()
         }
        
    }
    
    func checkReceivedInviteAccepted() async {
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
    }
    
    func checkSendInviteAccepted() async {
        let shared = await cloud.loadShare()
        guard let participantes = shared?.participants.count else { return }
        if participantes <= 1 {
            DispatchQueue.main.async {
                self.isSendInviteAccepted = false
            }
        } else {
            DispatchQueue.main.async {
                self.isSendInviteAccepted = true
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

//
//  Invite.swift
//  Macro
//
//  Created by Vitor Cheung on 04/10/22.
//

import Foundation
class Invite: ObservableObject {
    static var shared = Invite()
    @Published var isReceivedInviteAccepted: Bool = false
    @Published var isSendInviteAccepted: Bool = false
    
    private init() {
        Task {
            let isReceivedInviteAccepted = await CloudKitModel.shared.isReceivedInviteAccepted()
            let isSendInviteAccepted = await CloudKitModel.shared.isSendInviteAccepted()
            DispatchQueue.main.async {
                self.isReceivedInviteAccepted = isReceivedInviteAccepted
                self.isSendInviteAccepted = isSendInviteAccepted
            }
        }
    }
}

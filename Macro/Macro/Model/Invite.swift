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
    
    func cleanName(name: String?) -> String? {
        guard let strings = name?.split(separator: " ", omittingEmptySubsequences: false) else {
            return nil
        }
        
        return String(strings[1])
    }
    
    func isReady(income: Float) -> Bool {
        if isSendInviteAccepted && isReceivedInviteAccepted {
            UserDefault.userOnBoardingInvite()
            Task {
                var participantsNames: [String] = []
                if let participants = cloud.share?.participants {
                    for participant in participants {
                        guard let name = participant.userIdentity.nameComponents?.description else { return  }
                        participantsNames.append( name )
                    }
                }
                guard let username = cleanName(name: participantsNames.first) else { return }
                guard let partenername = cleanName(name: participantsNames.last) else { return }

                UserDefault.userOnBoardingUsername(username: username)
                
                let methodologySpent = MethodologySpent(valuesPercent: [50, 35, 15], namePercent: ["Essencial", "Prioridade", "Lazer"], nameCategory: "50-35-15")
                try? await cloud.post(model: methodologySpent)
                
                let user = User( name: username, income: income, dueData: 21, partner: partenername, notification: [1, 2], methodologySpent: methodologySpent)
                try? await cloud.post(model: user)
            }
            Task {
                let methodologyGoal = MethodologyGoal(weeks: 52, crescent: true)
                try? await cloud.post(model: methodologyGoal)
            }
            Task {
                await cloud.saveNotification(recordType: Goal.getType(), database: .dataShare)
            }
            Task {
                await cloud.saveNotification(recordType: Spent.getType(), database: .dataShare)
            }
            return true
        } else {
            return false
        }
    }
}

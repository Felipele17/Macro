//
//  OnBoardingStateViewModel.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 26/09/22.
//

import Foundation
import CloudKit
import SwiftUI

class OnBoardingViewModel: ObservableObject {
    
    @Published var onboardingFinished = false
    @Published var onboardingPage: Int = 0
    private var cloud = CloudKitModel.shared
    private var invite = Invite.shared
    
    init() {
        if invite.isReady() {
            onboardingFinished = true
        } else {
            onboardingFinished = false
        }
    }

    func checkButton() -> String {
        if onboardingPage == 3 {
            return EnumButtonText.shareButton.rawValue
        }
        return EnumButtonText.nextButton.rawValue
    }
    
    // MARK: Cloud
    /// it shares the invite by fetching, sending and receving the invite
    func sharingInvite() {
        Task {
            await cloud.loadShare()
            let isSendInviteAccepted = await invite.checkSendInviteAccepted()
            let isReceivedInviteAccepted = await invite.checkReceivedInviteAccepted()
            DispatchQueue.main.async { [self] in
                self.invite.isReceivedInviteAccepted = isReceivedInviteAccepted
                self.invite.isSendInviteAccepted = isSendInviteAccepted
                }
        }
        guard let sharingController = cloud.makeUIViewControllerShare() else { return }
        let window = UIApplication.shared.keyWindow
        window?.rootViewController?.present(sharingController, animated: true)
    }

    /// Checking if:    1. the Spent's methodology and username was got;   2. the Goal's methodology was posted;    3. the notification of the Goal and Spent was saved
    func initialPosts(income: Float) {
        Task {
            var participantsNames: [String] = []
            if let participants = cloud.getShare()?.participants {
                for participant in participants {
                    guard let name = participant.userIdentity.nameComponents?.description else { return  }
                    participantsNames.append( name )
                }
            }
            guard let username = invite.cleanName(name: participantsNames.first) else { return }
            guard let partenername = invite.cleanName(name: participantsNames.last) else { return }

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
    }
}

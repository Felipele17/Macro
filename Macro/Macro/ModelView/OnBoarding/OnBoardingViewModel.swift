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
    
    @Published var onboardingPage: Int = 0
    var cloud = CloudKitModel.shared
    let invite = Invite.shared

    func checkButton() -> String {
        if onboardingPage == 3 {
            return EnumButtonText.shareButton.rawValue
        }
        return EnumButtonText.nextButton.rawValue
    }

    /// it shares the invite by fetching, sending and receving the invite
    func sharingInvite() {
        Task {
            cloud.share = try await cloud.fetchShare()
            let isSendInviteAccepted = await cloud.isSendInviteAccepted()
            let isReceivedInviteAccepted = await cloud.isReceivedInviteAccepted()
            DispatchQueue.main.async { [self] in
                self.invite.isReceivedInviteAccepted = isReceivedInviteAccepted
                self.invite.isSendInviteAccepted = isSendInviteAccepted
                }
        }
        guard let sharingController = cloud.makeUIViewControllerShare() else { return }
        let window = UIApplication.shared.keyWindow
        window?.rootViewController?.present(sharingController, animated: true)
    }
    
}

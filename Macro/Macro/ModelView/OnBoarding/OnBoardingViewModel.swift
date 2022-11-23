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
    @Published var incomeTextField: String = ""
    @Published private var invite = Invite.shared
    private var cloud = CloudKitModel.shared
    private let methodologySpent = MethodologySpent(valuesPercent: [50, 35, 15], namePercent: ["Essencial", "Prioridade", "Lazer"], nameCategory: "50-35-15")
    let methodologyGoal = MethodologyGoal(weeks: 52, crescent: true)
    
    func checkOnboardingFinished() {
        onboardingFinished = invite.isReady()
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
        guard let sharingController = cloud.makeUIViewControllerShare() else { return }
        let window = UIApplication.shared.keyWindow
        window?.rootViewController?.present(sharingController, animated: true)
    }

    /// Checking if:    1. the Spent's methodology and username was got;   2. the Goal's methodology was posted;    3. the notification of the Goal and Spent was saved
    func initialPosts(income: Float) {
        if UserDefault.getFistPost() {
            return
        }
        UserDefault.setFistPost(isFistPost: true)
        Task.init {
            var participantsNames: [String] = []
            if let participants = try await cloud.getShare()?.participants {
                for participant in participants {
                    guard let name = participant.userIdentity.nameComponents?.description else { return  }
                    participantsNames.append( name )
                }
            }
            guard let username = self.invite.cleanName(name: participantsNames.first) else { return }
            guard let partenername = self.invite.cleanName(name: participantsNames.last) else { return }

            let user = User( name: username, income: income, dueData: 21, partner: partenername, notification: [1, 2], methodologySpent: methodologySpent)
            UserDefault.setUsername(username: username)
            
            Task.init {
                try? await cloud.post(model: methodologySpent)
            }
            Task.init {
                try? await cloud.post(model: user)
            }
        }
        Task.init {
            try? await cloud.post(model: methodologyGoal)
        }
        Task.init {
            await cloud.saveNotification(recordType: Goal.getType(), database: .dataShare)
        }
        Task.init {
            await cloud.saveNotification(recordType: Spent.getType(), database: .dataShare)
        }
    }
    
    func crateSpentCards(income: Float) -> [SpentsCard] {
        var spentCards: [SpentsCard] = []
        for index in 0 ..< methodologySpent.valuesPercent.count {
            spentCards.append(SpentsCard(id: index, valuesPercent: methodologySpent.valuesPercent[index], namePercent: methodologySpent.namePercent[index], moneySpented: 0.0, availableMoney: income*Float(methodologySpent.valuesPercent[index])/100))
        }
        return spentCards
    }
    
    func deleteShare() {
        Task {
            await CloudKitModel.shared.deleteShare()            
        }
    }
    
    func convertIncome() -> Float {
        //guard Float(incomeTextField) != nil else { return 0.0 }
        return Float(incomeTextField) ?? 0.0
    }
}

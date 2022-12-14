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
    @Published var incomeTextField: String = ((UserDefault.getIncome() == 0.0 ? "" : String(UserDefault.getIncome()).replacingOccurrences(of: ".", with: ",").transformToMoney()) ?? "")
    @Published private var invite = Invite.shared
    @Published var isSheetShare = false
    private var cloud = CloudKitModel.shared
    let methodologySpent = MethodologySpent(valuesPercent: [50, 35, 15], namePercent: ["Essencial", "Prioridade", "Lazer"], nameCategory: "50-35-15")
    var users: [User] = []
    let methodologyGoal = MethodologyGoal(weeks: 52, crescent: true)
    
    func checkOnboardingFinished() {
        onboardingFinished = invite.isReady()
    }

    func checkButton() -> String {
        if onboardingPage == 4 {
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
            
            UserDefault.setUsername(username: username)
            
            Task.init {
                try? await cloud.post(model: methodologySpent)
            }
            Task.init {
                users.append(User( name: username, income: income, dueData: 21, partner: partenername, notification: [1, 2], methodologySpent: methodologySpent))
                users.append(User( name: partenername, income: 0.0, dueData: 21, partner: username, notification: [1, 2], methodologySpent: methodologySpent))
                DispatchQueue.main.async {
                    self.onboardingFinished = true
                }
                if let user = users.first {
                    try? await cloud.post(model: user)
                }
            }
        }
        Task.init {
            do {
                try await cloud.post(model: methodologyGoal)
            } catch let error {
                print(error.localizedDescription)
            }
            
        }
        Task.init {
            await cloud.saveNotification(recordType: Goal.getType(), database: .dataShare)
            await cloud.saveNotification(recordType: Spent.getType(), database: .dataShare)
            await cloud.saveNotification(recordType: Goal.getType(), database: .dataPrivate)
            await cloud.saveNotification(recordType: Spent.getType(), database: .dataPrivate)
        }
    }
    
    func crateSpentCards(income: Float) -> [SpentsCard] {
        var spentCards: [SpentsCard] = []
        for index in 0 ..< methodologySpent.valuesPercent.count {
            spentCards.append(SpentsCard(id: index, valuesPercent: methodologySpent.valuesPercent[index], namePercent: methodologySpent.namePercent[index], moneySpented: 0.0, availableMoney: income*Float(methodologySpent.valuesPercent[index])/100, totalMoney: income*Float(methodologySpent.valuesPercent[index])/100))
        }
        return spentCards
    }
    
    func deleteShare() {
        Task {
            await CloudKitModel.shared.deleteShare()            
        }
    }
    
    func convertIncome() -> Float {
        return Float(incomeTextField) ?? 0.0
    }
    
}

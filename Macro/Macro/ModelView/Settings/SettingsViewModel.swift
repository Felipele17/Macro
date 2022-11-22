//
//  SettingsModelView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import Foundation

class SettingsViewModel: ObservableObject {

    private let userDefault = UserDefault()

    private let cloud = CloudKitModel.shared
    @Published var users: [User] = []

    func editUser() {
        Task.init {
            await cloud.update(model: users[0])
        }
    }
    
    func verifyIncomeUser() -> Float {
        guard let user = users.first else { return 0.0 }
        return user.income
    }
    
    func verifyPartnerUser() -> String {
        guard let user = users.first else { return "" }
        return user.partner
    }
    
    func deleteShare() {
        Task {
            await CloudKitModel.shared.deleteShare()
        }
    }
}

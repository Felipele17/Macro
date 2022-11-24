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

    func editUser(income: String) {
        guard let _ = users.first else { return }
        let verifyIncome = income.replacingOccurrences(of: ".", with: "").floatValue
        if verifyIncome != 0.0 {
            UserDefault.setIncome(income: UserDefault.getIncome()-users[0].income)
            users[0].income = verifyIncome
            Task.init {
                await cloud.update(model: users[0])
            }
            UserDefault.setIncome(income: UserDefault.getIncome()+verifyIncome)
        }
    }
    
    func verifyIncomeUser() -> String {
        guard let user = users.first else { return "carregando" }
        return String(user.income).replacingOccurrences(of: ".", with: ",").transformToMoney() ?? ""
    }
    
    func verifyPartnerUser() -> String {
        guard let user = users.first else { return "" }
        return user.partner
    }
    
    func verifyDueDataUser() -> Int {
        guard let user = users.first else { return 0 }
        return user.dueData
    }
    
    func deleteShare() {
        Task {
            await CloudKitModel.shared.deleteShare()
        }
    }
}

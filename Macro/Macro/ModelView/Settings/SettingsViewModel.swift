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
}

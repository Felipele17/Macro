//
//  Settings.swift
//  Macro
//
//  Created by Gabriele Namie on 26/10/22.
//

import SwiftUI

struct Settings: Identifiable {
    var id = UUID()
    var groupName: String
    @State var settingsValue: [SettingsValues]
    
    static let settingsGroups: [Settings] = [
        Settings(groupName: "", settingsValue: [
            SettingsValues(name: "Vencimento dos gastos", icon: "calendar"),
            SettingsValues(name: "Metodologias financeiras", icon: "questionmark.circle"),
            SettingsValues(name: "Histórico de gastos", icon: "newspaper"),
            SettingsValues(name: "Conectado com", icon: "heart")
        ]),
        Settings(groupName: "Notificações", settingsValue: [
            SettingsValues(name: "Depósito do parceiro", icon: "envelope.open"),
            SettingsValues(name: "Fim do limite", icon: "flag"),
            SettingsValues(name: "Cumprir meta", icon: "rosette")
        ])
    ]
}

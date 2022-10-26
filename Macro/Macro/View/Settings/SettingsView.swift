//
//  SettingsView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct SettingsView: View {
    @State var settings: [Settings] = Settings.settingsGroups

    var body: some View {
        List {
            ForEach(settings) { setting in
                Section(header: Text(setting.groupName)) {
                    ForEach(settings) { setting in
                //        setting[0]
                    }
                }
                
            }
        }
        .navigationTitle("Configurações")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(settings: [Settings(groupName: "tchau", settingsValue: [SettingsValues(name: "tchau", icon: "heart")])])
    }
}

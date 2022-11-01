//
//  SettingsView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct SettingsView: View {
    @State private var toggle: Bool = false
    @State private var selectDate = Date()
    var body: some View {
            List {
                Section {
                    NavigationLink {
                    }label: {
                        VStack(alignment: .leading) {
                            Text("\(UserDefaults.standard.string(forKey: "username") ?? "")")
                                .font(.custom(EnumFonts.semibold.rawValue, size: 22))
                            Text("Renda mensal: \(UserDefaults.standard.string(forKey: "income") ?? "") ")
                            
                        }
                    }
                } .listRowSeparator(.hidden)
                Section {
                    NavigationLink {
                        DatePicker(
                            "Start Date",
                            selection: $selectDate,
                            displayedComponents: [.date]
                        )
                    }label: {
                        Image(systemName: "calendar")
                            .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                        Text("Vencimento dos gastos")
                    }
                    NavigationLink {
                        MethodologyView()
                    }label: {
                        Image(systemName: "questionmark.circle")
                            .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                        Text( "Metodologias financeiras")
                    }
                    NavigationLink {
                        HistorySpentsView()
                    }label: {
                        Image(systemName: "newspaper")
                            .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                        Text("Histórico de gastos")
                    }
                    NavigationLink {
                    }label: {
                        Image(systemName: "heart")
                            .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                        Text( "Conectado com")
                    }
                }
                Section(header: Text("Notificação")) {
                    Toggle(isOn: $toggle) {
                        HStack {
                            Image(systemName: "envelope.open")
                                .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                            Text("Depósito do parceiro")
                                .foregroundColor(Color(EnumColors.title.rawValue))
                        }
                    }
                    Toggle(isOn: $toggle) {
                        HStack {
                            Image(systemName: "flag")
                                .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                            Text("Fim do limite")
                                .foregroundColor(Color(EnumColors.title.rawValue))
                        }
                    }
                    Toggle(isOn: $toggle) {
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                            Text("Cumprir meta")
                                .foregroundColor(Color(EnumColors.title.rawValue))
                        }
                    }
                    
                } .textCase(.none)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Configurações")
            .font(.custom(EnumFonts.regular.rawValue, size: 17))
            .navigationBarTitleDisplayMode(.automatic)
        }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

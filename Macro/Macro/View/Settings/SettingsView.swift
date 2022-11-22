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
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @State var showSheet: Bool = false
    
    @Binding var path: NavigationPath
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading) {
                    Text("\(UserDefaults.standard.string(forKey: "username") ?? "")")
                        .font(.custom(EnumFonts.semibold.rawValue, size: 22))
                    Text("Renda mensal ").font(.custom(EnumFonts.regular.rawValue, size: 17))+Text("\(settingsViewModel.verifyIncomeUser())".floatValue.currency)
                        .font(.custom(EnumFonts.regular.rawValue, size: 17))
                    Text("Vencimento dos gastos")
                        .font(.custom(EnumFonts.regular.rawValue, size: 17))
                    }
                NavigationLink {
                    UserEditView()
                } label: {
                    Text("Editar dados do perfil")
                        .font(.custom(EnumFonts.regular.rawValue, size: 17))
                }
            }
            
            Section {
                NavigationLink {
                    MethodologySpentsView(path: $path)
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
            }
            .textCase(.none)
            Section {
                HStack {
                    Image(systemName: "heart")
                        .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                    Text("Conectado com ").font(.custom(EnumFonts.regular.rawValue, size: 17)) + Text("\(settingsViewModel.verifyPartnerUser())").font(.custom(EnumFonts.semibold.rawValue, size: 17))
                }
                Button {
                    self.showSheet.toggle()
                } label: {
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                        Text( "Desconectar")
                    }.foregroundColor(Color(.red))
                }
            }
            .actionSheet(isPresented: $showSheet, content: {
                ActionSheet(title: Text("Tem certeza que deseja desconectar com \(settingsViewModel.verifyPartnerUser())?"),
                            buttons: [
                                .destructive(Text("Desconectar")) {
                                    settingsViewModel.deleteShare()
                                },
                                .cancel()
                            ])
            })
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Configurações")
        .font(.custom(EnumFonts.regular.rawValue, size: 17))
        .navigationBarTitleDisplayMode(.automatic)
    }
}

//
// struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView(path: .constant(NavigationPath()))
//    }
// }

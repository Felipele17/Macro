//
//  SettingsView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var pathController: PathController
    @State private var toggle: Bool = false
    @State private var selectDate = Date()
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @State var showSheet: Bool = false
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading) {
                    Text("\(UserDefaults.standard.string(forKey: "username") ?? "")")
                        .font(.custom(EnumFonts.semibold.rawValue, size: 22))
                    Text("Renda mensal: ").font(.custom(EnumFonts.regular.rawValue, size: 17))+Text("\(settingsViewModel.verifyIncomeUser())".floatValue.currency)
                        .font(.custom(EnumFonts.semibold.rawValue, size: 17))
                    Text("Data para vencimento dos gastos: ").font(.custom(EnumFonts.regular.rawValue, size: 17))+Text("\(settingsViewModel.verifyDueDataUser())")
                        .font(.custom(EnumFonts.semibold.rawValue, size: 17))
                }.padding(.leading, 8)
                NavigationLink {
                    UserEditView(newValue: settingsViewModel.verifyIncomeUser())
                } label: {
                    Image(systemName: "square.and.pencil")
                        .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                    Text("Editar dados do perfil")
                        .font(.custom(EnumFonts.regular.rawValue, size: 17))
                }
            }
            
            Section {
                NavigationLink(value: EnumViewNames.methodologySpentsView) {
                    Image(systemName: "questionmark.circle")
                        .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                    Text( "Metodologias financeiras")
                }
                //                NavigationLink {
                //                    HistorySpentsView()
                //                }label: {
                //                    Image(systemName: "newspaper")
                //                        .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                //                    Text("Histórico de gastos")
                //                }
                //            }
                //            Section(header: Text("Notificação")) {
                //                Toggle(isOn: $toggle) {
                //                    HStack {
                //                        Image(systemName: "envelope.open")
                //                            .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                //                        Text("Depósito do parceiro")
                //                            .foregroundColor(Color(EnumColors.title.rawValue))
                //                    }
                //                }
                //                Toggle(isOn: $toggle) {
                //                    HStack {
                //                        Image(systemName: "flag")
                //                            .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                //                        Text("Fim do limite")
                //                            .foregroundColor(Color(EnumColors.title.rawValue))
                //                    }
                //                }
                //                Toggle(isOn: $toggle) {
                //                    HStack {
                //                        Image(systemName: "calendar")
                //                            .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                //                        Text("Cumprir meta")
                //                            .foregroundColor(Color(EnumColors.title.rawValue))
                //                    }
                //                }
                //            }
                //            .textCase(.none)
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
                            Text("Desconectar")
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
            .background(Color(EnumSpentsinfo.backgroundSpentsColor.rawValue))
            .listStyle(.insetGrouped)
            .navigationTitle("Configurações")
            .font(.custom(EnumFonts.regular.rawValue, size: 17))
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

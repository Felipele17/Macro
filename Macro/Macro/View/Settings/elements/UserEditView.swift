//
//  SettingsEditView.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 10/11/22.
//

import SwiftUI

struct UserEditView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @State private var validTextField: Bool = true
    @State private var showAlert: Bool = false
    @State var newValue: String
    @FocusState var keyboardIsFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Renda Mensal")
                .foregroundColor(Color("Title"))
                .font(.custom(EnumFonts.regular.rawValue, size: 22))
            TextField("Valor atual: \(settingsViewModel.verifyIncomeUser())", text: $newValue)
                .keyboardType(.decimalPad)
                .foregroundColor(Color(EnumColors.subtitle.rawValue))
                .focused($keyboardIsFocused)
                .onChange(of: newValue) { _ in
                    if let newValue = newValue.transformToMoney() {
                        self.newValue = newValue
                        validTextField = true
                    } else {
                        validTextField = false
                    }
                }
            Rectangle()
                .frame(height: 1.0, alignment: .bottom)
                .padding(.trailing, 30)
                .padding(.bottom, 10)
                .foregroundColor(Color(EnumColors.subtitle.rawValue))
            
            Spacer()
        }
        .padding(.top, 60)
        .padding(.leading, 20)
        .navigationBarTitle("Editar", displayMode: .inline)
        .background(Color(EnumColors.backgroundScreen.rawValue))
        
        .toolbar {
            Button("Salvar") {
                if validTextField {
                    settingsViewModel.editUser(income: newValue)
                    dismiss()
                } else {
                    showAlert.toggle()
                }
            } .alert("Há algo errado com a sua nova renda.", isPresented: $showAlert) {
                Button {
                    showAlert.toggle()
                } label: {
                    Text("OK")
                }
            }
        }
        
    }
    
}

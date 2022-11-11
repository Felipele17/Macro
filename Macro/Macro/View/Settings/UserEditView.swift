//
//  SettingsEditView.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 10/11/22.
//

import SwiftUI

struct UserEditView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding <PresentationMode>
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @State var validTextField: Bool = false
    @State var value: String = ""
    @FocusState var keyboardIsFocused: Bool
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Renda Mensal")
                .foregroundColor(Color("Title"))
                .font(.custom(EnumFonts.regular.rawValue, size: 22))
            TextField("Novo valor", text: $value)
                .keyboardType(.decimalPad)
                .foregroundColor(Color(EnumColors.subtitle.rawValue))
                .focused($keyboardIsFocused)
            Rectangle()
                .frame(height: 1.0, alignment: .bottom)
                .padding(.trailing, 30)
                .foregroundColor(Color(EnumColors.subtitle.rawValue))
                .onChange(of: value) { _ in
                    if let value = value.transformToMoney() {
                        self.value = value
                        validTextField = true
                    } else {
                        validTextField = false
                    }
                }
            Spacer()
        }
        .padding(.top, 60)
        .padding(.leading, 20)
        .navigationBarTitle("Editar", displayMode: .inline)
        .toolbar {
            Button("Salvar") {
                guard let user = settingsViewModel.users.first else { return } // verifying if we have the first user (the owner of the phone)
                if validTextField { // verifying if the text is valid
                    if !(Float(value) == UserDefaults.standard.float(forKey: "income")) { // verifying if the value that it's coming is new or it is the same
                        settingsViewModel.users[0].income = Float(value) ?? 0.0
                        settingsViewModel.editUser()
                    }
                }
                self.presentationMode.wrappedValue.dismiss()
            }
            .disabled(!validTextField)
        }
        
    }
    
}

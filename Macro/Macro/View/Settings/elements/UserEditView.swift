//
//  SettingsEditView.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 10/11/22.
//

import SwiftUI

struct UserEditView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var date = Date()
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @State var validTextField: Bool = false
    @State var newValue: String = ""
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
            TextField("Novo valor", text: $newValue)
                .keyboardType(.decimalPad)
                .foregroundColor(Color(EnumColors.subtitle.rawValue))
                .focused($keyboardIsFocused)
            Rectangle()
                .frame(height: 1.0, alignment: .bottom)
                .padding(.trailing, 30)
                .padding(.bottom, 10)
                .foregroundColor(Color(EnumColors.subtitle.rawValue))
                .onChange(of: newValue) { _ in
                    if let newValue = newValue.transformToMoney() {
                        self.newValue = newValue
                        validTextField = true
                    } else {
                        validTextField = false
                    }
                }
            Text("Data de Pagamento")
                .foregroundColor(Color("Title"))
                .font(.custom(EnumFonts.regular.rawValue, size: 22))
            DatePicker(
                    "Start Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
            
            Spacer()
        }
        .padding(.top, 60)
        .padding(.leading, 20)
        .navigationBarTitle("Editar", displayMode: .inline)
        .toolbar {
            Button("Salvar") {
                guard settingsViewModel.users.first != nil else { return } // verifying if we have the first user (the owner of the phone)
                if validTextField { // verifying if the text is valid
                    if !(Float(newValue) == UserDefaults.standard.float(forKey: "income")) { // verifying if the value that it's coming is new or it is the same
                        settingsViewModel.users[0].income = Float(newValue) ?? 0.0
                        settingsViewModel.editUser()
                        
                        UserDefault.setIncome(income: settingsViewModel.users[0].income)
                    }
                }
                dismiss()
            }
            .disabled(!validTextField)
        }
        
    }
    
}

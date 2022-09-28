//
//  FormsSpends.swift
//  Macro
//
//  Created by Gabriele Namie on 23/09/22.
//

import SwiftUI

struct FormView: View {
    @State private var textFieldSelection = ""
    @State private var pickerSelection = "One"
    @State private var isToggleOn = false
    @State private var datePickerSelection = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Nome").foregroundColor(Color("Title")).font(.custom("SFProText-Regular", size: 22))) {
                    TextField("Ex: Luz", text: $textFieldSelection)
                        .underlineTextField()
                        .listRowBackground(Color.clear)
                }.textCase(.none)
                
                Section(header: Text("Ícone").foregroundColor(Color("Title")).font(.custom("SFProText-Regular", size: 22))) {
                    Picker(selection: $pickerSelection, label: Text("")) {
                        ForEach(["One", "Two", "Three"], id: \.self) {
                            Text($0).tag($0)
                        }
                    } .listRowBackground(Color.clear)
                        .underlineTextField()
                }.textCase(.none)
                
                Section(header: Text("Valor(R$)").foregroundColor(Color("Title")).font(.custom("SFProText-Regular", size: 22))) {
                    TextField("Ex: Luz", text: $textFieldSelection)
                        .listRowBackground(Color.clear)
                        .underlineTextField()
                }.textCase(.none)
                
                Section(header: Text("Data").foregroundColor(Color("Title")).font(.custom("SFProText-Regular", size: 22))) {
                        DatePicker("", selection: $datePickerSelection, displayedComponents: [.date])
                            .listRowBackground(Color.clear)
                            .labelsHidden()
                        // .underlineTextField()
                }.textCase(.none)
            }.navigationBarTitle("Gastos", displayMode: .inline)
            
        }
    }
}
extension View {
    func underlineTextField() -> some View {
        self
            .overlay(Rectangle().frame(height: 1).padding(.top, 35))
            .foregroundColor(Color("LineColorForms"))
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}

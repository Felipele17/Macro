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
                         .listRowBackground(Color.clear)
                 Spacer()
                     .listRowBackground(Color.clear)
             }.textCase(.none)
            
             
             Section(header: Text("Ícone").foregroundColor(Color("Title")).font(.custom("SFProText-Regular", size: 22))) {
                 Picker(selection: $pickerSelection, label: Text("")) {
                   ForEach(["One", "Two", "Three"], id: \.self) {
                     Text($0).tag($0)
                   }
                 } .listRowBackground(Color.clear)
//                 Spacer()
//                     .listRowBackground(Color.clear)
             }.textCase(.none)
             
             Section(header: Text("Valor(R$)").foregroundColor(Color("Title")).font(.custom("SFProText-Regular", size: 22))) {
                 TextField("Ex: Luz", text: $textFieldSelection)
                       .listRowBackground(Color.clear)
//                 Spacer()
//                     .listRowBackground(Color.clear)
             }.textCase(.none)
             
             Section(header: Text("Data").foregroundColor(Color("Title")).font(.custom("SFProText-Regular", size: 22))) {
                 DatePicker("", selection: $datePickerSelection, displayedComponents: [.date])
                       .listRowBackground(Color.clear)
//                 Spacer()
//                     .listRowBackground(Color.clear)
             }.textCase(.none)
         }.navigationBarTitle("Gastos", displayMode: .inline)

           
       }
     }
//    @State var incomeTextField: Float
//    @FocusState var keyboardIsFocused: Bool
//    let formatter: NumberFormatter = {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        return formatter
//    }()
//
//    var body: some View {
//            VStack(alignment: .leading) {
//                Form {
//                    Text("Nome")
//                        .padding(.leading, 24)
//                    TextField("Ex: Luz", value: $incomeTextField, formatter: formatter)
//                        .keyboardType(.default)
//                        .foregroundColor(.black)
//                        .padding(.leading, 24)
//                        .focused($keyboardIsFocused)
//                    Rectangle()
//                        .frame(height: 1.0, alignment: .bottom)
//                        .padding(.leading, 24)
//                        .padding(.trailing, 24)
//                        .foregroundColor(Color("LineColorForms"))
//                }
//
//                Group {
//                    Text("Ícone")
//                        .padding(.leading, 24)
//                    TextField("Ex: ", value: $incomeTextField, formatter: formatter)
//                        .foregroundColor(.black)
//                        .padding(.leading, 24)
//                        .focused($keyboardIsFocused)
//                    Rectangle()
//                        .frame(height: 1.0, alignment: .bottom)
//                        .padding(.leading, 24)
//                        .padding(.trailing, 24)
//                        .foregroundColor(Color("LineColorForms"))
//                }
//
//                Group {
//                    Text("Valor (R$)")
//                        .padding(.leading, 24)
//                    TextField("Ex: 100,00", value: $incomeTextField, formatter: formatter)
//                        .keyboardType(.decimalPad)
//                        .foregroundColor(.black)
//                        .padding(.leading, 24)
//                        .focused($keyboardIsFocused)
//                    Rectangle()
//                        .frame(height: 1.0, alignment: .bottom)
//                        .padding(.leading, 24)
//                        .padding(.trailing, 24)
//                        .foregroundColor(Color("LineColorForms"))
//                }
//
//                Group {
//                    Text("Data")
//                        .padding(.leading, 24)
//                    TextField("Ex: 23/09/2022", value: $incomeTextField, formatter: formatter)
//                        .padding(.leading, 24)
//                        .keyboardType(.decimalPad)
//                        .foregroundColor(.black)
//                        .focused($keyboardIsFocused)
//                    Rectangle()
//                        .frame(height: 1.0, alignment: .bottom)
//                        .padding(.leading, 24)
//                        .padding(.trailing, 24)
//                        .foregroundColor(Color("LineColorForms"))
//                }
//
//            }
//        .navigationTitle("Gasto")
//            .navigationBarTitleDisplayMode(.inline)
//
//    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}

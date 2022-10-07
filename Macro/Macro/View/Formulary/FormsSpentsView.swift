//
//  FormsSpends.swift
//  Macro
//
//  Created by Gabriele Namie on 23/09/22.
//

import SwiftUI

struct FormsSpentsView: View {
    @StateObject var viewModel: SpentViewModel
    @Environment(\.presentationMode) var presentationMode: Binding <PresentationMode>
    @State var spent: Spent
    
    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()
    
    var body: some View {
            Form {
                Section(header: Text("Nome").foregroundColor(Color("Title")).font(.custom("SFProText-Regular", size: 22))) {
                    TextField("Ex: Luz", text: $viewModel.nameSpent)
                        .underlineTextField()
                        .listRowBackground(Color.clear)
                }.textCase(.none)
                
                Section(header: Text("Ícone").foregroundColor(Color("Title")).font(.custom("SFProText-Regular", size: 22))) {
                    Picker(selection: $viewModel.iconPicker, label: Text("")) {
                        ForEach(["One", "Two", "Three"], id: \.self) {
                            Text($0).tag($0)
                        }
                    } .listRowBackground(Color.clear)
                        .underlineTextField()
                }.textCase(.none)
                
                Section(header: Text("Valor(R$)").foregroundColor(Color("Title")).font(.custom("SFProText-Regular", size: 22))) {
                    TextField("Ex: R$200,00", value: $viewModel.valueSpent, formatter: formatter)
                        .listRowBackground(Color.clear)
                        .keyboardType(.decimalPad)
                        .underlineTextField()
                }.textCase(.none)
                
                Section(header: Text("Data").foregroundColor(Color("Title")).font(.custom("SFProText-Regular", size: 22))) {
                    DatePicker("", selection: $viewModel.datePickerSpent, displayedComponents: [.date])
                            .listRowBackground(Color.clear)
                            .labelsHidden()
                        // .underlineTextField()
                }.textCase(.none)
            }.navigationBarTitle("Gastos", displayMode: .inline)
                .toolbar {
                    Button {
                        viewModel.postSpent()
                        
                        let spentAux = spent
                        spentAux.title = viewModel.nameSpent
                        spentAux.icon = viewModel.iconPicker
                        spentAux.value = viewModel.valueSpent
                        
                        spent = spentAux
                        
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Salvar")
                    }

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

//struct FormView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            FormsSpentsView(viewModel: SpentViewModel(categoryPercent: EnumCategoryPercent.work), spent: .constant(Spent(title: "", value: 1, icon: "", date: Date(), categoryPercent: EnumCategoryPercent.work)))
////            FormsSpentsView(viewModel: SpentViewModel(categoryPercent: EnumCategoryPercent.work), popToView: .constant(false))
//        }
//    }
//}

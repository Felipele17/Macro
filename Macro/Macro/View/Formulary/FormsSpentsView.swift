//
//  FormsSpends.swift
//  Macro
//
//  Created by Gabriele Namie on 23/09/22.
//

import SwiftUI

struct FormsSpentsView: View {
    @EnvironmentObject var viewModel: SpentViewModel
    @Environment(\.presentationMode) var presentationMode: Binding <PresentationMode>
    @State var showingSheet: Bool = false
    @Binding var spent: Spent
    
    @State var title = ""
    @State var icon = ""
    @State var value = ""
    @State var date = Date.now
    
    @State var validTextField = false
    
    var colorIcon: String
    var isPost: Bool
    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()
    
    var body: some View {
            Form {
                Section(header: Text("Nome").foregroundColor(Color("Title")).font(.custom("SFProText-Regular", size: 22))) {
                    TextField( "Ex: Luz", text: $title)
                        .underlineTextField()
                        .listRowBackground(Color.clear)
                }.textCase(.none)
                
                Section(header: Text("Ícone").foregroundColor(Color("Title")).font(.custom("SFProText-Regular", size: 22))) {
                    Button(">") {
                        showingSheet.toggle()
                    }.sheet(isPresented: $showingSheet) {
                        ModalView(selectedIcon: $icon, colorIcon: colorIcon)
                    } .padding(.leading, UIScreen.screenWidth*0.77)
                    .listRowBackground(Color.clear)
                            .underlineTextField()
                }.textCase(.none)
                
                Section(header: Text("Valor(R$)").foregroundColor(Color("Title")).font(.custom("SFProText-Regular", size: 22))) {
                    TextField("Ex: R$200,00", text: $value)
                        .listRowBackground(Color.clear)
                        .keyboardType(.decimalPad)
                        .underlineTextField()
                }.textCase(.none)
                    .onChange(of: value) { _ in
                        if let value = value.transformToMoney() {
                            self.value = value
                            validTextField = true
                        } else {
                            validTextField = false
                        }
                    }
                
                Section(header: Text("Data").foregroundColor(Color("Title")).font(.custom("SFProText-Regular", size: 22))) {
                    DatePicker("", selection: $date, displayedComponents: [.date])
                            .listRowBackground(Color.clear)
                            .labelsHidden()
                }.textCase(.none)
            }
            .navigationBarTitle("Gastos", displayMode: .inline)
                .toolbar {
                    Button {
                        if !validTextField { return }
                        let value = value.floatValue
                        var spent = Spent(title: title, value: value, icon: icon, date: date, categoryPercent: self.spent.categoryPercent)
                        spent.id = self.spent.id
                        if isPost {
                            if viewModel.postSpent(spent: spent) {
                                self.presentationMode.wrappedValue.dismiss()
                                self.spent = spent
                            }
                        } else {
                            if viewModel.editSpent(spent: spent) {
                                self.presentationMode.wrappedValue.dismiss()
                                self.spent = spent
                            }
                        }
                    } label: {
                        if isPost {
                            Text("Salvar")
                        } else {
                            Text("Edit")
                        }
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
//            FormsSpentsView (
//                viewModel: SpentViewModel(spent: Spent.emptyMock(category: 50)),
//                arraySpents: .constant([Spent.emptyMock(category: 50),Spent.emptyMock(category: 50)]),
//                colorIcon: EnumColors.backgroundCardMetaColor.rawValue,
//                isPost: true
//            )
//        }
//    }
//}

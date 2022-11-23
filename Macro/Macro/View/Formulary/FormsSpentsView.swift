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
    var id = UUID()
    var spentsCard: SpentsCard
    @State var showingSheet: Bool = false
    @State var isValidValue: Bool = false
    @State var title = ""
    @State var icon = ""
    @State var value: String = ""
    @State var date = Date.now
    
    @State var validTextField = false
    
    var colorIcon: String
    var isPost: Bool
    
    var body: some View {
        Form {
            Section(header: Text("Nome").foregroundColor(Color("Title")).font(.custom("SFProText-Regular", size: 22))) {
                TextField( "Ex: Luz", text: $title)
                    .underlineTextField()
                    .listRowBackground(Color.clear)
            }.textCase(.none)
            Section(header: Text("Ícone").foregroundColor(Color("Title")).font(.custom("SFProText-Regular", size: 22))) {
                Button {
                    showingSheet.toggle()
                } label: {
                    VStack(alignment: .leading) {
                        HStack {
                            Label("", systemImage: icon)
                                .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                                .font(.custom("SFProText-Regular", size: 26))
                            Label("", systemImage: "chevron.right")
                        }
                    }
                }
                .sheet(isPresented: $showingSheet) {
                    ModalView(selectedIcon: $icon, colorIcon: colorIcon)
                        .presentationDetents([.medium, .medium, .fraction(0.75)])
                }
                .padding(.leading, UIScreen.screenWidth*0.58)
                .listRowBackground(Color.clear)
                .underlineTextField()
                
            }.textCase(.none)
            
            Section(header: Text("Valor(R$)").foregroundColor(Color("Title")).font(.custom("SFProText-Regular", size: 22))) {
                TextField("Ex: R$200,00", text: $value)
                    .listRowBackground(Color.clear)
                    .keyboardType(.decimalPad)
                    .underlineTextField()
                    .onChange(of: value) { _ in
                        if let stringMoney = value.transformToMoney() {
                            value = stringMoney
                            isValidValue = true
                        } else {
                            isValidValue = false
                        }
                    }
            }.textCase(.none)
            Section(header: Text("Data").foregroundColor(Color("Title")).font(.custom("SFProText-Regular", size: 22))) {
                DatePicker("", selection: $date, displayedComponents: [.date])
                    .listRowBackground(Color.clear)
                    .labelsHidden()
            }.textCase(.none)
        }
        .navigationBarTitle("Gastos", displayMode: .inline)
        .toolbar {
            Button {
                if isValidValue {
                    let value = value.replacingOccurrences(of: ".", with: "").floatValue
                    let newSpent = Spent(id: id, title: title, value: value, icon: icon, date: date, categoryPercent: spentsCard.valuesPercent)
                    if viewModel.updateArray(isPost: isPost, newSpent: newSpent, spentsCard: spentsCard) {
                        presentationMode.wrappedValue.dismiss()
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

// struct FormView_Previews: PreviewProvider {
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
// }

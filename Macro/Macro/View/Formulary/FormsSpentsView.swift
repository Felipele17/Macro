//
//  FormsSpends.swift
//  Macro
//
//  Created by Gabriele Namie on 23/09/22.
//

import SwiftUI

struct FormsSpentsView: View {
    @ObservedObject var viewModel: SpentViewModel
    @Binding var arraySpents: [Spent]
    @Environment(\.presentationMode) var presentationMode: Binding <PresentationMode>
    @State var showingSheet: Bool = false
    @State var title: String = ""
    @State var icon: String = ""
    @State var value: Float = 0.0
    @State var date: Date = Date.now
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
                    TextField("Ex: R$200,00", value: $value, formatter: formatter)
                        .listRowBackground(Color.clear)
                        .keyboardType(.decimalPad)
                        .underlineTextField()
                }.textCase(.none)
                
                Section(header: Text("Data").foregroundColor(Color("Title")).font(.custom("SFProText-Regular", size: 22))) {
                    DatePicker("", selection: $date, displayedComponents: [.date])
                            .listRowBackground(Color.clear)
                            .labelsHidden()
                }.textCase(.none)
            }.navigationBarTitle("Gastos", displayMode: .inline)
                .toolbar {
                    Button {
                        let spent = Spent(title: title, value: value, icon: icon, date: date, categoryPercent: viewModel.spent.categoryPercent)
                        if isPost {
                            viewModel.postSpent(spent: spent)
                            arraySpents.append(viewModel.spent)
                        } else {
                            viewModel.editSpent(spent: spent)
                        }
                        self.presentationMode.wrappedValue.dismiss()
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

//
//  FormsEditGoals.swift
//  Macro
//
//  Created by Gabriele Namie on 28/09/22.
//

import SwiftUI

struct FormsEditGoals: View {
    @State var nameGoal: String
    @State var priority: Int
//    @State private var valueGoal = 0.0
    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()
    
    @ObservedObject private var viewModel = GoalViewModel()
    @Binding var goal: Goal
    
    @Environment(\.presentationMode) var presentationMode: Binding <PresentationMode>
    
    var body: some View {
        VStack {
            HStack {
                Text("Nome")
                    .foregroundColor(Color("Title"))
                    .font(.custom("SFProText-Regular", size: 28))
                Spacer()
            }
            .padding(.bottom)
            TextField("Ex: Luz", text: $nameGoal)
                    .underlineTextField()
                    .listRowBackground(Color.clear)
                //            Section(header: Text("Valor(R$)").foregroundColor(Color("Title")).font(.custom("SFProText-Regular", size: 22))) {
                //                TextField("Ex: R$500,00", value: $valueGoal, formatter: formatter)
                //                    .underlineTextField()
                //                    .keyboardType(.decimalPad)
                //                    .listRowBackground(Color.clear)
                //            }.textCase(.none)
            PrioritySelector(priority: $priority)
            Spacer()
        }
        .padding()
        .navigationBarTitle("Editar", displayMode: .inline)
            .toolbar {
                Button("Salvar") {
                    goal.title = nameGoal
                    goal.priority = priority
//                    goal.value = Float(valueGoal)
                    viewModel.editGoal(goal: goal)
                    
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
    }
}

//struct FormsEditGoals_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            FormsEditGoals(goal: .constant(Goal(title: "", value: 1, weeks: 1, motivation: "", priority: 1, methodologyGoal: MethodologyGoal(weeks: 2, crescent: true))))
//        }
//    }
//}

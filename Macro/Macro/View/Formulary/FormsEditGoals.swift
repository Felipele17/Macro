//
//  FormsEditGoals.swift
//  Macro
//
//  Created by Gabriele Namie on 28/09/22.
//

import SwiftUI

struct FormsEditGoals: View {
    @State private var nameGoal = ""
    @State private var valueGoal = 0.0
    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()
    
    @ObservedObject private var viewModel = GoalViewModel()
    @Binding var goal: Goal
    
    @Environment(\.presentationMode) var presentationMode: Binding <PresentationMode>
    
    var body: some View {
        Form {
            Section(header: Text("Nome").foregroundColor(Color("Title")).font(.custom("SFProText-Regular", size: 22))) {
                TextField("Ex: Luz", text: $nameGoal)
                    .underlineTextField()
                    .listRowBackground(Color.clear)
            }.textCase(.none)
            
            Section(header: Text("Valor(R$)").foregroundColor(Color("Title")).font(.custom("SFProText-Regular", size: 22))) {
                TextField("Ex: R$500,00", value: $valueGoal, formatter: formatter)
                    .underlineTextField()
                    .keyboardType(.decimalPad)
                    .listRowBackground(Color.clear)
            }.textCase(.none)
        }.navigationBarTitle("Editar", displayMode: .inline)
            .toolbar {
                Button("Salvar") {
                    let goalAux = goal
                    goalAux.title = nameGoal
                    goalAux.value = Float(valueGoal)
                    goal = goalAux
                    viewModel.editGoal(goal: goal)
                    
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
    }
}

struct FormsEditGoals_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FormsEditGoals(goal: .constant(Goal(title: "", value: 1, weeks: 1, motivation: "", priority: 1, methodologyGoal: MethodologyGoal(weeks: 2, crescent: true))))
        }
    }
}

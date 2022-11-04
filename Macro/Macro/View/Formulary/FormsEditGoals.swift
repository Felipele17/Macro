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
    @Binding var goal: Goal
    @Environment(\.presentationMode) var presentationMode: Binding <PresentationMode>
    
    @StateObject private var viewModel = GoalViewModel()
    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()
    
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
            PrioritySelector(priority: $priority)
            Spacer()
        }
        .padding()
        .navigationBarTitle("Editar", displayMode: .inline)
            .toolbar {
                Button("Salvar") {
                    goal.title = nameGoal
                    goal.priority = priority
                    viewModel.editGoal(goal: goal)
                    
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
    }
}

// struct FormsEditGoals_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            FormsEditGoals(goal: .constant(Goal(title: "", value: 1, weeks: 1, motivation: "", priority: 1, methodologyGoal: MethodologyGoal(weeks: 2, crescent: true))))
//        }
//    }
// }

//
//  FormsGoals.swift
//  Macro
//
//  Created by Gabriele Namie on 23/09/22.
//

import SwiftUI

struct FormsGoalsNameView: View {
    @EnvironmentObject var viewModel: GoalViewModel
    @State var goal: Goal
    @Binding var path: NavigationPath
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Qual o nome da sua meta?")
                    .font(.custom("SFProText-Medium", size: 34))
                    .padding(1)
                Text("Coloque um nome que te lembre de alcançar esta meta")
                    .padding(10)
                TextField("Ex.: Carro novo", text: $goal.title)
                
                    .foregroundColor(Color(EnumColors.title.rawValue))
                    .underlineTextField()
                    .padding(5)
                Spacer()
                NavigationLink {
                    FormsGoalsValueView(goal: goal, path: $path)
                } label: {
                    TemplateTextButton(text: EnumButtonText.nextButton.rawValue, isTextFieldEmpty: goal.title.isEmpty)
                }
                .isDetailLink(false)
                .disabled(goal.title.isEmpty)
            }
            .padding(20)
        }
    }
}

// struct FormGoalsView_Previews: PreviewProvider {
//    static var previews: some View {
//        FormsGoalsNameView(goal: Goal(title: "", value: 0.0, weeks: 0, motivation: "", priority: 0, methodologyGoal: MethodologyGoal(weeks: 52, crescent: true)), popToRoot: .constant(true))
//    }
// }

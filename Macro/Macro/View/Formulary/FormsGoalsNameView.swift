//
//  FormsGoals.swift
//  Macro
//
//  Created by Gabriele Namie on 23/09/22.
//

import SwiftUI

struct FormsGoalsNameView: View {
    
    @State private var pageIndex = 0
    @State var goal: Goal
    @Binding var goals: [Goal]
    @Binding var popToRoot: Bool
    
    var body: some View {
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
                GoalNextButton(goal: goal, goals: $goals, text: EnumButtonText.nextButton.rawValue, isEmptyTextField: goal.title == "" ? true : false, pageIndex: $pageIndex, popToRoot: $popToRoot)
            }
            .padding(20)
    }
}

//struct FormGoalsView_Previews: PreviewProvider {
//    static var previews: some View {
//        FormsGoalsNameView(goal: Goal(title: "", value: 0.0, weeks: 0, motivation: "", priority: 0, methodologyGoal: MethodologyGoal(weeks: 52, crescent: true)), popToRoot: .constant(true))
//    }
//}

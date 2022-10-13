//
//  FormsGoals.swift
//  Macro
//
//  Created by Gabriele Namie on 23/09/22.
//

import SwiftUI

struct FormsGoalsNameView: View {
    
    @State private var goalField: String = ""
    @State private var pageIndex = 0
    @State var goal = Goal(title: "", value: 0.0, weeks: 0, motivation: "", priority: 0, methodologyGoal: MethodologyGoal(weeks: 1, crescent: false))
    @Binding var popToRoot: Bool
    
    var body: some View {
            VStack(alignment: .leading) {
                Text("Qual o nome da sua meta?")
                    .font(.custom("SFProText-Medium", size: 34))
                    .padding(1)
                Text("Coloque um nome que te lembre de alcançar esta meta")
                    .padding(10)
                TextField("Ex.: Carro novo", text: $goalField)
                
                    .foregroundColor(.black)
                    .underlineTextField()
                    .padding(5)
                Spacer()
                GoalNextButton(goal: goal, text: EnumButtonText.nextButton.rawValue, textField: $goalField, pageIndex: $pageIndex, popToRoot: $popToRoot)
                    .onTapGesture {
                       goal.title = goalField

                    }
            }
            .padding(20)
    }
}

struct FormGoalsView_Previews: PreviewProvider {
    static var previews: some View {
        FormsGoalsNameView(popToRoot: .constant(true))
    }
}

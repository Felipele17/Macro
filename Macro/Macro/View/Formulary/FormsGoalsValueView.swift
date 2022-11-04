//
//  FormsGoalsValueView.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 28/09/22.
//

import SwiftUI

struct FormsGoalsValueView: View {
    @State var goal: Goal
    @Binding var goals: [Goal]
    @State var value = ""
    @State var validTextField = false
    @FocusState var keyboardIsFocused: Bool
    @Binding var popToRoot: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Quanto você deseja guardar?")
                .font(.custom("SFProText-Medium", size: 34))
                .padding(1)
            Text("Depositando R$ 1 por semana de forma gradual, em 52 semanas você irá ter em sua conta R$ 1.378,00")
                .padding(10)
            TextField("Ex.: R$ 1.378,00", text: $value)
                .foregroundColor(.black)
                .keyboardType(.decimalPad)
                .focused($keyboardIsFocused)
                .underlineTextField()
                .padding(5)
                .onChange(of: value) { _ in
                    if let value = value.transformToMoney() {
                        self.value = value
                        goal.value = value.floatValue
                        validTextField = true
                    } else {
                        validTextField = false
                    }
                }
            PrioritySelector(priority: $goal.priority)
            Spacer()
            NavigationLink {
                FormsGoalMotivationView(goal: goal, goals: $goals, popToRoot: $popToRoot)
            } label: {
                TemplateTextButton(text: EnumButtonText.nextButton.rawValue, isTextFieldEmpty: validTextField)
            }
            .isDetailLink(false)
            .disabled(validTextField)
        }
        .padding(20)
    }
}

//struct FormsGoalsValueView_Previews: PreviewProvider {
//    static var previews: some View {
//        FormsGoalsValueView(goal: .constant(Goal(title: "", value: 1, weeks: 1, motivation: "", priority: 1, methodologyGoal: MethodologyGoal(weeks: 1, crescent: true))), popToRoot: .constant(true))
//    }
//}

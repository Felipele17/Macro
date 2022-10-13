//
//  FormsGoalsValueView.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 28/09/22.
//

import SwiftUI

struct FormsGoalsValueView: View {
    @Binding var goal: Goal
    @State private var pageIndex = 1
    @FocusState var keyboardIsFocused: Bool
    @Binding var popToRoot: Bool
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Quanto você deseja guardar?")
                .font(.custom("SFProText-Medium", size: 34))
                .padding(1)
            Text("Depositando R$ 1 por semana de forma gradual, em 52 semanas você irá ter em sua conta R$ 1.378,00")
                .padding(10)
            TextField("Ex.: R$ 1.378,00", value: $goal.value, formatter: formatter)
                .foregroundColor(.black)
                .keyboardType(.decimalPad)
                .focused($keyboardIsFocused)
                .underlineTextField()
                .padding(5)
            Text("Nível de Prioridade")
                .font(.custom(EnumFonts.medium.rawValue, size: 28))
                .padding(.top, 30)
            HStack {
                Button {
                    goal.priority = 1
                    
                } label: {
                    VStack {
                        Image("Noz1")
                        Text("Pequena")
                            .tint(.black)
                            .hoverEffect(.automatic)
                    }
                }
                .opacity(goal.priority == 1 ? 1.0 : 0.5)
                
                Spacer()
                
                Button {
                    goal.priority = 2
      
                } label: {
                    VStack {
                        Image("Noz2")
                        Text("Média")
                            .tint(.black)
                            .hoverEffect(.automatic)
                    }
                }
                .opacity(goal.priority == 2 ? 1.0 : 0.5)
                
                Spacer()
                
                Button {
                    goal.priority = 3
         
                } label: {
                    VStack {
                        Image("Noz3")
                        Text("Grande")
                            .tint(.black)
                            .hoverEffect(.automatic)
                    }
                }.opacity(goal.priority == 3 ? 1.0 : 0.5)
            }
            .padding(10)
            Spacer()
            GoalNextButton(goal: $goal, text: EnumButtonText.nextButton.rawValue, isEmptyTextField: goal.value == 0.0 ? false : true, pageIndex: $pageIndex, popToRoot: $popToRoot)
        }
        .padding(20)
    }
}

struct FormsGoalsValueView_Previews: PreviewProvider {
    static var previews: some View {
        FormsGoalsValueView(goal: .constant(Goal(title: "", value: 1, weeks: 1, motivation: "", priority: 1, methodologyGoal: MethodologyGoal(weeks: 1, crescent: true))), popToRoot: .constant(true))
    }
}

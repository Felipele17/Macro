//
//  LabelNextButton.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 28/09/22.
//

import SwiftUI

struct GoalNextButton: View {
    @Binding var goal: Goal
    var text: String
    var isEmptyTextField: Bool
    @Binding var pageIndex: Int
    @Binding var popToRoot: Bool
    
    var body: some View {
        
        NavigationLink {
                // changing the view
                switch pageIndex {
                case 0:
                    FormsGoalsValueView(goal: goal, popToRoot: $popToRoot)
                default:
                    FormsGoalMotivationView(goal: goal, popToRoot: $popToRoot)
                }
            
        } label: {
            TemplateTextButton(text: text, isTextFieldEmpty: isEmptyTextField)
        }
        .isDetailLink(false)
        .disabled(textField.isEmpty)

    }
}

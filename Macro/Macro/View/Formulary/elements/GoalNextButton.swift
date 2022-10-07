//
//  LabelNextButton.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 28/09/22.
//

import SwiftUI

struct GoalNextButton: View {
    var goal: Goal
    var text: String
    @Binding var textField: String
    @Binding var pageIndex: Int
    
    var body: some View {
        
        NavigationLink {
                // changing the view
                switch pageIndex {
                case 0:
                    FormsGoalsValueView(goal: goal)
                default:
                    FormsGoalMotivationView(goal: goal)
                }
            
        } label: {
            TemplateTextButton(text: text, isTextFieldEmpty: textField.isEmpty)
        }
        .disabled(textField.isEmpty)

    }
}

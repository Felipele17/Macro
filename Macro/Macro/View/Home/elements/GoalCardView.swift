//
//  GoalCardView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct GoalCardView: View, Identifiable {
    var id: Int
    let goal: Goal
    let progress: ProgressBarCardView
    var body: some View {
        VStack(alignment: .leading) {
            Text(goal.title)
            
                .font(.system(.title2))
                .fontWeight(.semibold)
                .padding(.bottom, 4)
        
           //arrumar
            Text("Motivação:").font(.footnote).fontWeight(.medium) + Text(goal.motivation!).font(.footnote)
            Spacer()
            
            progress
            
            HStack {
                VStack(alignment: .leading) {
                    
                    Text("R$\(goal.value/10) ")
                        .font(.body).bold()
                        + Text("de R$\(goal.value)").font(.body .weight(.light))
                    
                    Text("Faltam \(goal.weeks) semanas").font(.footnote)
                        .padding(.top, 1)
                        
                    Spacer()
                }
                
               // goal.priority
                Spacer()
            }
        }
        .padding(.leading, 20)
        .padding(.top, 20)
        .foregroundColor(.white)
        .background(Color("CardGoalsColor"))
        .cornerRadius(8)
    }
}

struct GoalCardView_Previews: PreviewProvider {
    static var previews: some View {
        GoalCardView(id: 1, goal: Goal(title: "Carro Novo", value: 20000, weeks: 48, motivation: "Realização de um sonho", priority: 1, methodologyGoal: MethodologyGoal(weeks: 52, crescent: true)), progress: ProgressBarCardView())
            .previewInterfaceOrientation(.portrait)
    }
}

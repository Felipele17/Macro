//
//  GoalCardView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct GoalCardView: View, Identifiable {
    @ObservedObject var viewModel: GoalCardViewModel
    var id: Int
    let goal: Goal
    var body: some View {
            VStack(alignment: .leading) {
                
                HStack {
                    Text(goal.title)
                        .font(.custom("SFProText-Semibold", size: 22))
                        .padding(.bottom, 2)
                    Spacer()
                    Image("\(viewModel.setImagebyPriority(goal: goal))")
                        .padding(.trailing)
                }
                
                Text("Motivação:").font(.custom("SFProText-Medium", size: 13)) + Text(goal.motivation ?? "").font(.custom("SFProText-Regular", size: 13))
                Spacer()
                
                ProgressBarCardView(percentsProgress: viewModel.calc(goal: goal))
                    .padding(.top, 2)
                    .padding(.bottom, 2)
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        
                        Text("R$\(goal.getAllMoneySave()) ")
                            .font(.custom("SFProText-Medium", size: 17))
                            + Text("de R$\(goal.value)").font(.custom("SFProText-Light", size: 17))
                        
                        Text("Faltam \(52 - goal.weeks) semanas").font(.custom("SFProText-Regular", size: 13))
                            
                        Spacer()
                    }
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
        GoalCardView(viewModel: GoalCardViewModel(), id: 1, goal: Goal(title: "Carro Novo", value: 5000, weeks: 48, motivation: "Realização de um sonho", priority: 1, methodologyGoal: MethodologyGoal(weeks: 52, crescent: true)))
            .previewInterfaceOrientation(.portrait)
    }
}

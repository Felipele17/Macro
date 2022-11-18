//
//  WeakGoalsView.swift
//  Macro
//
//  Created by Vitor Cheung on 14/09/22.
//

import SwiftUI

struct WeakGoalsView: View {
    @EnvironmentObject var goalViewModel: GoalViewModel
    @State private var animate = false
    @State var checkWeek: Bool
    @Binding var goal: Goal
    var title: String
    var valor: Float
    private var animationScale: CGFloat {
        checkWeek ? 0.7 : 1.3
    }
    
    var body: some View {
            Button {
                if animate { return }
                self.animate = true
                self.checkWeek = checkWeek ? false : true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    goal.weeks += checkWeek ? 1 : -1
                    goalViewModel.editGoal(goal: goal)
                })
            } label: {
                HStack(spacing: 0) {
                Image(systemName: checkWeek ?  "checkmark.circle.fill" : "circle")
                    .foregroundColor(Color(EnumColors.circleMeta.rawValue))
                    .font(.custom(EnumFonts.medium.rawValue, size: 22))
                    .scaleEffect(animate ? animationScale : 1)
                Text(title)
                    .font(.custom(EnumFonts.medium.rawValue, size: 17))
                Spacer()
                Text("\(valor)".floatValue.currency)
                    .font(.custom(EnumFonts.medium.rawValue, size: 20))
                    .padding(.vertical)
            }
                .animation(.default.speed(1))
        }
    }
}

// struct WeakGoalsView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeakGoalsView(title: "Carro", valor: 100.0, isSelected: .constant(false))
//    }
// }

//
//  CarouselView.swift
//  Macro
//
//  Created by Vitor Cheung on 09/09/22.
//

import SwiftUI

struct CarouselView: View {
    @EnvironmentObject var goalViewModel: GoalViewModel
    let width: CGFloat
    let heigth: CGFloat
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                if goalViewModel.goals.isEmpty {
                    VStack {
                        Text("Oh não, você não tem nenhuma meta com o seu parceiro ainda. Clique no '+' para criar uma.")
                            .font(.custom(EnumFonts.regular.rawValue, size: 17))
                            .padding([.leading, .bottom])
                            .frame(width: UIScreen.screenWidth, alignment: .center)
                        Image(EnumImageName.doubleSquirrels.rawValue)

                    }
                } else {
                    ForEach(goalViewModel.goals) { goal in
                        NavigationLink(destination: GoalsView(goal: goal)) {
                            GoalCardView(goal: goal, didFinished: goalViewModel.isGoalFinished(goal: goal))
                                .frame(width: width, height: heigth)
                                .padding([.leading, .bottom])
                        }
                    }
                }
                
            }
        }
    }
}

// struct CarouselView_Previews: PreviewProvider {
//    static var previews: some View {
//        CarouselView(width: 325.0, heigth: 200.0, goals: .constant([
//             Goal(title: "Carro Novo", value: 20000, weeks: 48, motivation: "Realização de um sonho", priority: 1, methodologyGoal: MethodologyGoal(weeks: 52, crescent: true)),
//             Goal(title: "Carro Novo", value: 20000, weeks: 48, motivation: "Realização de um sonho", priority: 1, methodologyGoal: MethodologyGoal(weeks: 52, crescent: true)),
//             Goal(title: "Carro Novo", value: 20000, weeks: 48, motivation: "Realização de um sonho", priority: 1, methodologyGoal: MethodologyGoal(weeks: 52, crescent: true))
//                    ]))
//    }
// }

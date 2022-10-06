//
//  CarouselView.swift
//  Macro
//
//  Created by Vitor Cheung on 09/09/22.
//

import SwiftUI

struct CarouselView: View {
    
    let width: CGFloat
    let heigth: CGFloat
    var viewsCells: [GoalCardView]
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(viewsCells) { cell in
                    NavigationLink(destination: GoalsView(goal: cell.goal)) {
                        cell
                            .frame(width: width, height: heigth)
                            .padding([.leading, .bottom])
                    }
                }
            }
        }
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView (width: 325.0, heigth: 200.0, viewsCells: [
            GoalCardView(viewModel: GoalCardViewModel(), id: 1, goal: Goal(title: "Carro Novo", value: 20000, weeks: 48, motivation: "Realização de um sonho", priority: 1, methodologyGoal: MethodologyGoal(weeks: 52, crescent: true))),
            GoalCardView(viewModel: GoalCardViewModel(), id: 2, goal: Goal(title: "Carro Novo", value: 20000, weeks: 48, motivation: "Realização de um sonho", priority: 1, methodologyGoal: MethodologyGoal(weeks: 52, crescent: true))),
            GoalCardView(viewModel: GoalCardViewModel(), id: 3, goal: Goal(title: "Carro Novo", value: 20000, weeks: 48, motivation: "Realização de um sonho", priority: 1, methodologyGoal: MethodologyGoal(weeks: 52, crescent: true)))
        ])
    }
}

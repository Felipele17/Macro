//
//  CarouselView.swift
//  Macro
//
//  Created by Vitor Cheung on 09/09/22.
//

import SwiftUI

struct CarouselView: View {
    
    @ObservedObject var viewModel: CarouselViewModel
    
    var viewsCells: [GoalCardView]
    
    var body: some View {
        ZStack {
            ForEach(viewsCells) { cell in
                NavigationLink(destination: GoalsView(goal: Goal(title: "OI", value: 20, weeks: 12, motivation: "CHJFBHIEW", priority: 1, methodologyGoal: MethodologyGoal(weeks: 52, crescent: true)))) {
                    cell
                        .frame(width: viewModel.width, height: viewModel.heigth)
                        .offset(x: viewModel.myXOffset(cell.id), y: 0)
                }

            }
        }
        .highPriorityGesture(
            DragGesture()
                .onChanged { value in
                    viewModel.onChange(value: value.translation.width)
                }
                .onEnded {value in
                    viewModel.onEnded(value: value.translation.width, viewsCellsCount: viewsCells.count)
                }
        )
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView(viewModel: CarouselViewModel( width: 325.0, heigth: 200.0), viewsCells: [
            GoalCardView(viewModel: GoalCardViewModel(), id: 1, goal: Goal(title: "Carro Novo", value: 20000, weeks: 48, motivation: "Realização de um sonho", priority: 1, methodologyGoal: MethodologyGoal(weeks: 52, crescent: true))),
            GoalCardView(viewModel: GoalCardViewModel(), id: 2, goal: Goal(title: "Carro Novo", value: 20000, weeks: 48, motivation: "Realização de um sonho", priority: 1, methodologyGoal: MethodologyGoal(weeks: 52, crescent: true))),
            GoalCardView(viewModel: GoalCardViewModel(), id: 3, goal: Goal(title: "Carro Novo", value: 20000, weeks: 48, motivation: "Realização de um sonho", priority: 1, methodologyGoal: MethodologyGoal(weeks: 52, crescent: true)))
        ])
    }
}

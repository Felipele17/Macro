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
    var goals: [Goal]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(goals) { goal in
                    NavigationLink(destination: GoalsView(goal: goal)) {
                        GoalCardView(goal: goal)
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
        CarouselView (width: 325.0, heigth: 200.0, goals: [
                                Goal(title: "Carro Novo", value: 20000, weeks: 48, motivation: "Realização de um sonho", priority: 1, methodologyGoal: MethodologyGoal(weeks: 52, crescent: true)) ,
                                Goal(title: "Carro Novo", value: 20000, weeks: 48, motivation: "Realização de um sonho", priority: 1, methodologyGoal: MethodologyGoal(weeks: 52, crescent: true)),
                                Goal(title: "Carro Novo", value: 20000, weeks: 48, motivation: "Realização de um sonho", priority: 1, methodologyGoal: MethodologyGoal(weeks: 52, crescent: true))
        ])
    }
}

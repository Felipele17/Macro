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
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(goal.title)
                    .font(.title2).bold()
                    .padding(.bottom, 2)
                
   //             Text("Motivação:").font(.footnote).bold() + Text(goal.motivation).font(.footnote)
                
                Text("R$\(goal.value/10) ")
                    .font(.body).bold()
                    + Text("de R$\(goal.value)").font(.body .weight(.light))
                    
                Spacer()
            }
            .padding(.leading, 20)
              .foregroundColor(.white)
              .padding(.top, 20)
//            goal.priority
//                .padding(.top)
            Spacer()
        }
    }
}

//struct GoalCardView_Previews: PreviewProvider {
//    static var previews: some View {
//    GoalCardView(id: 1, goal: Goal(title: "META", motivation: "Quero guardar dindin", priority: Image("Nozes"), value: 20, check: 900, category: .work))
  //  }
//}

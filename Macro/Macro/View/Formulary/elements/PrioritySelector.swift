//
//  PrioritySelector.swift
//  Macro
//
//  Created by Vitor Cheung on 24/10/22.
//

import SwiftUI

struct PrioritySelector: View {
    @Binding var priority: Int
    var body: some View {
        VStack {
            Text("Nível de Prioridade")
                .font(.custom(EnumFonts.medium.rawValue, size: 28))
                .padding(.top, 30)
            HStack {
                Button {
                    priority = 1
                } label: {
                    VStack {
                        Image("Noz1")
                        Text("Pequena")
                            .tint(.black)
                            .hoverEffect(.automatic)
                    }
                }
                .opacity(priority == 1 ? 1.0 : 0.5)
                Spacer()
                Button {
                    priority = 2
                } label: {
                    VStack {
                        Image("Noz2")
                        Text("Média")
                            .tint(.black)
                            .hoverEffect(.automatic)
                    }
                }
                .opacity(priority == 2 ? 1.0 : 0.5)
                Spacer()
                Button {
                    priority = 3
                } label: {
                    VStack {
                        Image("Noz3")
                        Text("Grande")
                            .tint(.black)
                            .hoverEffect(.automatic)
                    }
                }.opacity(priority == 3 ? 1.0 : 0.5)
            }
            .padding(10)
        }
    }
}

// struct PrioritySelector_Previews: PreviewProvider {
//    static var previews: some View {
//        PrioritySelector()
//    }
// }

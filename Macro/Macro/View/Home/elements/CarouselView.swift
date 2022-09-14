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
                NavigationLink(destination: GoalsView()) {
                    cell
                        .frame(width: viewModel.width, height: viewModel.heigth)
                        .offset(x: viewModel.myXOffset(cell.id), y: 0)
                }
            }
        }
        .gesture(
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
            GoalCardView(id: 1),
            GoalCardView(id: 2),
            GoalCardView(id: 3)
        ])
    }
}

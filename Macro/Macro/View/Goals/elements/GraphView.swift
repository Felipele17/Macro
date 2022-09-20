//
//  GraphView.swift
//  Macro
//
//  Created by Vitor Cheung on 14/09/22.
//

import SwiftUI

struct GraphView: View {
    
    @ObservedObject var chartPieViewModel: ChartPieViewModel
    
    var body: some View {
        VStack {
            Text("26 semanas")
                .font(.title2)
                ZStack {
                    ForEach(0..<chartPieViewModel.countChartData()) { index in
                        Circle()
                            .trim(from: index == 0 ? 0.0 : chartPieViewModel.chartDatas[index-1].percent/2,
                              to: chartPieViewModel.chartDatas[index].percent/2)
                            .stroke(chartPieViewModel.chartDatas[index].color, lineWidth: UIScreen.screenWidth/12)
                            .animation(.spring())
                            .rotationEffect(.degrees(-180))
                    }
                VStack {
                    Text("\(chartPieViewModel.chartDatas[0].percent*100)%")
                        .font(.title)
                    Text("completo")
                }.offset(y: -20)
            }
        }.onAppear {self.chartPieViewModel.calc()}
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView(chartPieViewModel: ChartPieViewModel(
            chartDatas: [ChartData(color: .green, value: 80),
                         ChartData(color: .cyan, value: 40)]
            )
        )
    }
}

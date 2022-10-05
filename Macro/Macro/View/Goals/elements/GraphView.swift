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
        ZStack {
            ForEach(0..<chartPieViewModel.countChartData()) { index in
                if !(chartPieViewModel.percents.isEmpty) {
                    Circle()
                        .trim(from: index == 0 ? 0.0 : chartPieViewModel.percents[index-1]/2, to: chartPieViewModel.percents[index]/2)
                        .stroke(chartPieViewModel.chartDatas[index].color, lineWidth: UIScreen.screenWidth/12)
                        .animation(.spring())
                        .rotationEffect(.degrees(-180))
                }
            }
            VStack {
                Text("\((chartPieViewModel.percents.first ?? 0)*100, specifier: "%.1f")%")
                    .font(.custom(EnumFonts.regular.rawValue, size: 20))
                Text("completo")
                    .font(.custom(EnumFonts.regular.rawValue, size: 20))
                    .padding(.bottom, 50)
                Text("Faltam R$\(chartPieViewModel.chartDatas[0].value, specifier: "%.2f")")
                    .font(.custom(EnumFonts.semibold.rawValue, size: 20))
                Text("de R$\(chartPieViewModel.chartDatas[1].value, specifier: "%.2f")")
                    .font(.custom(EnumFonts.light.rawValue, size: 20))
            }
        }
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

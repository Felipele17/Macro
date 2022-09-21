//
//  File.swift
//  Macro
//
//  Created by Vitor Cheung on 14/09/22.
//

import Foundation
import SwiftUI
class ChartPieViewModel: ObservableObject {
    @Published var chartDatas: [ChartData]
    
    init(chartDatas: [ChartData]) {
        self.chartDatas = chartDatas
    }
    
    func countChartData() -> Int {
        return chartDatas.count
    }
    
    func totalValue() -> CGFloat {
        var valorTotal = 0.0
        for chartData in chartDatas {
            valorTotal += chartData.value
        }
        return valorTotal
    }
  
    func calc() {
        var value: CGFloat = 0
        
        for idn in 0..<chartDatas.count {
            chartDatas[idn].percent = chartDatas[idn].value/totalValue()
            value += chartDatas[idn].percent
            chartDatas[idn].percent = value
        }
    }
}

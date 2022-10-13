//
//  EnumSpentsColors.swift
//  Macro
//
//  Created by Gabriele Namie on 30/09/22.
//

import SwiftUI

struct SpentsCard: Identifiable {
    var id: Int
    var colorName: String
    var valuesPercent: Int
    var namePercent: String
    var moneySpented: Float
    var avalibleMoney: Float
    
    init(id: Int, valuesPercent: Int, namePercent: String, moneySpented: Float, avalibleMoney: Float) {
        let color = [EnumSpentsinfo.essencialsColor.rawValue, EnumSpentsinfo.priorityColor.rawValue,  EnumSpentsinfo.leisureColor.rawValue]
        self.id = id
        self.colorName = color[id]
        self.valuesPercent = valuesPercent
        self.namePercent = namePercent
        self.moneySpented = moneySpented
        self.avalibleMoney = avalibleMoney
    }
}

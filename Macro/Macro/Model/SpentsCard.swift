//
//  EnumSpentsColors.swift
//  Macro
//
//  Created by Gabriele Namie on 30/09/22.
//

import SwiftUI

struct SpentsCard: Identifiable, Hashable {
    var id: Int
    var colorName: String
    var colorName2: String
    var valuesPercent: Int
    var namePercent: String
    var moneySpented: Float
    var availableMoney: Float
    
    init(id: Int, valuesPercent: Int, namePercent: String, moneySpented: Float, availableMoney: Float) {
        let color = [EnumSpentsinfo.essencialsColor.rawValue, EnumSpentsinfo.priorityColor.rawValue, EnumSpentsinfo.leisureColor.rawValue]
        let secondColor = [EnumSpentsinfo.secondEssencialsColor.rawValue, EnumSpentsinfo.secondPriorityColor.rawValue, EnumSpentsinfo.secondleisureColor.rawValue]
        self.id = id
        self.colorName = color[id]
        self.colorName2 = secondColor[id]
        self.valuesPercent = valuesPercent
        self.namePercent = namePercent
        self.moneySpented = moneySpented
        self.availableMoney = availableMoney
    }
    
    init() {
        let color = [EnumSpentsinfo.essencialsColor.rawValue, EnumSpentsinfo.priorityColor.rawValue, EnumSpentsinfo.leisureColor.rawValue]
        let secondColor = [EnumSpentsinfo.secondEssencialsColor.rawValue, EnumSpentsinfo.secondPriorityColor.rawValue, EnumSpentsinfo.secondleisureColor.rawValue]
        self.id = -1
        self.colorName = color[0]
        self.colorName2 = secondColor[0]
        self.valuesPercent = -1
        self.namePercent = ""
        self.moneySpented = -1
        self.availableMoney = -1
    }
}

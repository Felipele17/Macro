//
//  EnumSpentsColors.swift
//  Macro
//
//  Created by Gabriele Namie on 30/09/22.
//

import SwiftUI

struct SpentsCards: Identifiable, Hashable, Equatable {
    var id: Int
    var colorName: String
    var title: String
    
    static var spentsCards: [SpentsCards] = [
        SpentsCards(id: 1, colorName: EnumSpentsinfo.essencialsColor.rawValue, title: EnumSpentsinfo.essencialsTitle.rawValue),
        SpentsCards(id: 2, colorName: EnumSpentsinfo.priorityColor.rawValue, title: EnumSpentsinfo.priorityTitle.rawValue),
        SpentsCards(id: 3, colorName: EnumSpentsinfo.leisureColor.rawValue, title: EnumSpentsinfo.leisureTitle.rawValue),
    ]
}

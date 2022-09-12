//
//  CarouselViewModel.swift
//  Macro
//
//  Created by Vitor Cheung on 12/09/22.
//

import Foundation
import SwiftUI

class CarouselViewModel: ObservableObject {
    
    @Published private var itemCell = 0.0
    @Published private var draggingItem = 0.0
    
    let width: CGFloat
    let heigth: CGFloat
    
    init(width: CGFloat, heigth: CGFloat) {
        self.width = width
        self.heigth = heigth
    }
    
    func myXOffset(_ item: Int) -> CGFloat {
        return ((width*6.5/6.0)*CGFloat(item)) - (width*6.8/6.0) - draggingItem
    }
    
    func onChange(value: Double) {
        draggingItem -= value/45
    }
    
    func onEnded(value: Double, viewsCellsCount: Int) {
        if value>0 {
            if itemCell != 0 {
                itemCell -= 1
            }
        } else {
            if itemCell < Double(viewsCellsCount-1) {
                itemCell += 1
            }
        }
        withAnimation {
            draggingItem = (width*6.5/6.0) * CGFloat(itemCell)
        }
    }
    
}

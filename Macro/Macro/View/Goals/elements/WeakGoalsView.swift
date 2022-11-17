//
//  WeakGoalsView.swift
//  Macro
//
//  Created by Vitor Cheung on 14/09/22.
//

import SwiftUI

struct WeakGoalsView: View {
    var title: String
    var valor: Float
    @Binding var isSelected: Bool
    @State private var animate = false
    private let animationDuration: Double = 0.2
    private var animationScale: CGFloat {
        isSelected ? 0.7 : 1.3
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Button {
                self.animate = true
                DispatchQueue.main.asyncAfter(deadline: .now() + self.animationDuration, execute: {
                    self.animate = false
                    self.isSelected.toggle()
                    })
            } label: {
                Image(systemName: isSelected ?  "checkmark.circle.fill" : "circle")
                    .foregroundColor(Color(EnumColors.circleMeta.rawValue))
                    .font(.custom(EnumFonts.medium.rawValue, size: 22))
            } . scaleEffect(animate ? animationScale : 1)
                .animation(.easeIn(duration: animationDuration))
            
            Text(title)
                .font(.custom(EnumFonts.medium.rawValue, size: 17))
            Spacer()
            Text("\(valor)".floatValue.currency)
                .font(.custom(EnumFonts.medium.rawValue, size: 20))
                .padding(.vertical)
        }
    }
}

struct WeakGoalsView_Previews: PreviewProvider {
    static var previews: some View {
        WeakGoalsView(title: "Carro", valor: 100.0, isSelected: .constant(false))
    }
}

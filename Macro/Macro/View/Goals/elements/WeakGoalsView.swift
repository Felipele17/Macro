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
    var body: some View {
        HStack(spacing:0) {
            Label("", systemImage: "circle")
                .foregroundColor(Color(EnumColors.circleMeta.rawValue))
                .font(.custom(EnumFonts.medium.rawValue, size: 22))
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
        WeakGoalsView(title: "Carro", valor: 100.0)
    }
}

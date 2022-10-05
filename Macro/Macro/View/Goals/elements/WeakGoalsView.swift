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
        HStack {
            Label("", systemImage: "circle")
                .foregroundColor(Color(EnumColors.circleMeta.rawValue))
                .font(.custom(EnumFonts.medium.rawValue, size: 17))
                .padding(.leading)
            Text(title)
            Spacer()
            Text("R$\(valor, specifier: "%.2f")")
                .font(.custom(EnumFonts.medium.rawValue, size: 20))
                .padding()
        }
    }
}

struct WeakGoalsView_Previews: PreviewProvider {
    static var previews: some View {
        WeakGoalsView(title: "carro", valor: 100.0)
    }
}

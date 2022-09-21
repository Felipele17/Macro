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
                .font(.system(size: 36))
                .padding(.leading)
            Text(title)
            Spacer()
            Text("R$\(valor)")
                .bold()
                .font(.title3)
                .padding()
        }
    }
}

struct WeakGoalsView_Previews: PreviewProvider {
    static var previews: some View {
        WeakGoalsView(title: "carro", valor: 100.0)
    }
}

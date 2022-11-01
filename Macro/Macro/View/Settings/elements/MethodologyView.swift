//
//  MethodologyView.swift
//  Macro
//
//  Created by Gabriele Namie on 27/10/22.
//

import SwiftUI

struct MethodologyView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("EssencialsImage")
                Text("Gastos essenciais")
            }
            Text("Foque 50% da sua renda com os gastos que não podem ser adiados.")
                .padding(.bottom)
            Text("Ex.: Se sua renda for de R$3000 utilize R$1500 para pagar as contas mensais da sua casa.")
            HStack {
                Image("EssencialsImage")
                Text("Gastos essenciais")
            }
            Text("Foque 50% da sua renda com os gastos que não podem ser adiados.")
                .padding(.bottom)
            Text("Ex.: Se sua renda for de R$3000 utilize R$1500 para pagar as contas mensais da sua casa.")
            
        }.navigationTitle("Método 50-15-35")
            .font(.custom(EnumFonts.regular.rawValue, size: 17))
            .navigationBarTitleDisplayMode(.automatic)
    }
}

struct MethodologyView_Previews: PreviewProvider {
    static var previews: some View {
        MethodologyView()
    }
}

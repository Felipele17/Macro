//
//  MotivationView.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 28/09/22.
//

import SwiftUI

struct MotivationView: View {
    
    private var motivations: [String] = ["Guardar dinheiro", "Realização de um sonho", "Sempre quis conquistar essa meta"]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Qual a motivação?")
                .font(.custom("SFProText-Medium", size: 34))
                .padding(1)
            Text("Selecione qual motivação mais se encaixa na sua meta")
                .padding(10)
            MotivationCard(text: motivations[0])
            MotivationCard(text: motivations[1])
            MotivationCard(text: motivations[2])
            Spacer()
        }
        .padding(20)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    // saving
                    print("saving...")
                } label: {
                    Text("Salvar")
                }

            }
        }
    }
}

struct MotivationView_Previews: PreviewProvider {
    static var previews: some View {
        MotivationView()
    }
}

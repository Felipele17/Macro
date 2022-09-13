//
//  SpentsDetailsCardView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct SpentsDetailsCardView: View {
    var body: some View {
        HStack {
            ZStack {
                Color.brown
                    .cornerRadius(10)
                Image(systemName: "car.fill")
            }.frame(width: UIScreen.screenWidth/9, height: UIScreen.screenWidth/9, alignment: .leading)
            VStack {
                Text("Roda carro")
                Text("25/09/2021")
            }
            Spacer()
            Text("R$199,99")
                .padding()
        }
    }
}

struct SpentsDetailsCardView_Previews: PreviewProvider {
    static var previews: some View {
        SpentsDetailsCardView()
    }
}

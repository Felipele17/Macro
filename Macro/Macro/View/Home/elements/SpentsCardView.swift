//
//  SpentsCardView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct SpentsCardView: View {
    let spentsCards: SpentsCards
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Color(self.spentsCards.colorName)
                HStack {
                    Text(self.spentsCards.title)
                        .foregroundColor(.white)
                    Spacer()
                    Label("", systemImage: "chevron.right")
                        .foregroundColor(.white)
                }
            }
            Color(EnumSpentsinfo.backgroundSpentsColor.rawValue)
            HStack(alignment: .top) {
                Text("Limite disponível")
                    .foregroundColor(Color("Title"))
                //                            Label("", systemImage: "chevron.right")
                //                                .foregroundColor(.white)
            }
        }.cornerRadius(12)
        
    }
}

struct SpentsCardView_Previews: PreviewProvider {
    static var previews: some View {
        SpentsCardView(spentsCards: SpentsCards(id: 1, colorName: "PriorityColor", title: "Prioridades"))
    }
}

//
//  SpentsCardView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct SpentsCardView: View {
    let spentsCard: SpentsCard
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Color(self.spentsCard.colorName)
                HStack {
                    Text(self.spentsCard.namePercent)
                        .foregroundColor(.white)
                    Spacer()
                    Label("", systemImage: "chevron.right")
                        .foregroundColor(.white)
                }
            }
            Color(EnumSpentsinfo.backgroundSpentsColor.rawValue)
            HStack(alignment: .top) {
                Text("\(spentsCard.avalibleMoney)")
                    .foregroundColor(Color("Title"))
                //                            Label("", systemImage: "chevron.right")
                //                                .foregroundColor(.white)
            }
        }.cornerRadius(12)
        
    }
}

struct SpentsCardView_Previews: PreviewProvider {
    static var previews: some View {
        SpentsCardView(spentsCard: SpentsCard(id: 1, valuesPercent: 1, namePercent: "oi", avalibleMoney: 100))
    }
}

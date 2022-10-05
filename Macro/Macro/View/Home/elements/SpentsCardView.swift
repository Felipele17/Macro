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
        VStack(spacing: 0) {
            ZStack {
                Color(self.spentsCards.colorName)
                HStack (alignment: .center) {
                    Text(self.spentsCards.title)
                        .font(.custom(EnumFonts.medium.rawValue, size: 22))
                        .foregroundColor(.white)
                        .padding(.leading, 8)
                    Spacer()
                    Label("", systemImage: "chevron.right")
                        .font(.custom(EnumFonts.medium.rawValue, size: 22))
                        .foregroundColor(.white)
                }
                //                            Label("", systemImage: "chevron.right")
                //                                .foregroundColor(.white)
            }
            //.padding(.bottom)
            ZStack {
                Color(EnumSpentsinfo.backgroundSpentsColor.rawValue)
                
                HStack(alignment: .center) {
                    
                    Text("Limite disponível")
                        .font(.custom(EnumFonts.light.rawValue, size: 17))
                        .padding(.leading, 8)
                        .padding(.top, 8)
                        .foregroundColor(Color(EnumColors.title.rawValue))
                    Spacer()
                    
                } .padding(.bottom)
                
            }
        }
        .cornerRadius(12)
        .shadow(radius: 8, x: 2, y: 2)
        
    }
}

struct SpentsCardView_Previews: PreviewProvider {
    static var previews: some View {
        SpentsCardView(spentsCards: SpentsCards(id: 1, colorName: "PriorityColor", title: "Prioridades"))
    }
}

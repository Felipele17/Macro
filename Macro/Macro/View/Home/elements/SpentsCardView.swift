//
//  SpentsCardView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct SpentsCardView: View {
    var spentsCard: SpentsCard
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Color(spentsCard.colorName)
                HStack(alignment: .center) {
                    Text(spentsCard.namePercent)
                        .font(.custom(EnumFonts.medium.rawValue, size: 22))
                        .foregroundColor(.white)
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                        .padding(.leading, 8)
                    Spacer()
                    Label("", systemImage: "chevron.right")
                        .font(.custom(EnumFonts.medium.rawValue, size: 20))
                        .foregroundColor(.white)
                        .padding(.trailing, 8)
                }
            }
            
            ZStack {
                Color(EnumSpentsinfo.backgroundSpentsColor.rawValue)
                
                HStack(alignment: .center) {
                    
                    Text("Limite disponível")
                        .font(.custom(EnumFonts.light.rawValue, size: 17))
                        .padding(.leading, 8)
                        .foregroundColor(Color(EnumColors.title.rawValue))
                    Spacer()
                    Text("\(spentsCard.avalibleMoney)".floatValue.currency)
                        .font(.custom(EnumFonts.light.rawValue, size: 17))
                        .padding(.trailing, 8)
                        .foregroundColor(Color(EnumColors.title.rawValue))
                    
                } .padding(.bottom)
                    .padding(.top)
                
            }
        }
        .cornerRadius(12)
        .shadow(radius: 8, x: 2, y: 2)
        
    }
}

struct SpentsCardView_Previews: PreviewProvider {
    static var previews: some View {
        SpentsCardView(spentsCard: SpentsCard(id: 1, valuesPercent: 1, namePercent: "oi", avalibleMoney: 100))
    }
}

//
//  MotivationCard.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 28/09/22.
//

import SwiftUI

struct MotivationCard: View {
    
    var text: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(height: 50)
                .cornerRadius(13)
                // .foregroundColor(Color(.blue))
            
            Text(text)
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .cornerRadius(13)
        }
    }
}

struct MotivationCard_Previews: PreviewProvider {
    static var previews: some View {
        MotivationCard(text: "Casamento")
    }
}

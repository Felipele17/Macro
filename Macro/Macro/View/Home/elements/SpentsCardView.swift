//
//  SpentsCardView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct SpentsCardView: View,Identifiable {
    var id: Int
    var body: some View {
        ZStack {
            Color.red
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

struct SpentsCardView_Previews: PreviewProvider {
    static var previews: some View {
        SpentsCardView(id: 0)
    }
}

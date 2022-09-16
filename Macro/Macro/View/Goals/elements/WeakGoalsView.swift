//
//  WeakGoalsView.swift
//  Macro
//
//  Created by Vitor Cheung on 14/09/22.
//

import SwiftUI

struct WeakGoalsView: View {

    var body: some View {
        HStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .padding(UIScreen.screenHeight/80)
            Spacer()
            Text("R$200,00")
                .bold()
                .font(.title3)
                .padding(UIScreen.screenHeight/80)
        }
    }
}

struct WeakGoalsView_Previews: PreviewProvider {
    static var previews: some View {
        WeakGoalsView()
    }
}

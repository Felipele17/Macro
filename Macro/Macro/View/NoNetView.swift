//
//  NoNetView.swift
//  Macro
//
//  Created by Felipe Leite on 19/10/22.
//

import SwiftUI

struct NoNetView: View {
    var body: some View {
        VStack {
            Text("Oh não, estamos sem conexão com a internet. Tente se conectar em um wi-fi diferente ou dados móveis.")
                .multilineTextAlignment(.center)
            Image("NoNet")
                .padding(32)
        }
        .padding(20)
    }
}

struct NoNetView_Previews: PreviewProvider {
    static var previews: some View {
        NoNetView()
    }
}

//
//  InfoButton.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 21/09/22.
//

import SwiftUI

struct InfoButton: View {
    var infoButton: String

    var body: some View {
        NavigationLink {
            MethodologyView()
        } label: {
            Label("Informação", systemImage: infoButton)
                .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                .padding(.trailing)
            .padding(.top)
        }
    }
}

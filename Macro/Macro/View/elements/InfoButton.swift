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
            // view
        } label: {
            Label("Informação", systemImage: infoButton)
                .tint(.blue)
                .padding(.trailing)
            .padding(.top)
        }
    }
}

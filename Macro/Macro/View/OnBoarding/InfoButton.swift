//
//  InfoButton.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 21/09/22.
//

import SwiftUI

struct InfoButton: View {
    var infoButton: String
    @EnvironmentObject var viewModel: OnBoardingViewModel
    
    var body: some View {
        NavigationLink {
            MethodologySpentsView()
        } label: {
            Label("Informação", systemImage: infoButton)
                .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                .padding(.trailing)
                .padding(.top)
        }
    }
}

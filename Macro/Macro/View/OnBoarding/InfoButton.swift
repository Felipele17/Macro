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
            if viewModel.onboardingPage == 2 {
                MethodologySpentsView()
            }
            else {
                OnBoardingFlowView()
            }
            
        } label: {
            Label("Informação", systemImage: infoButton)
                .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                .padding(.trailing)
            .padding(.top)
        }
    }
}

//
//  MethodologyGoalsView.swift
//  Macro
//
//  Created by Gabriele Namie on 01/11/22.
//

import SwiftUI

struct MethodologyGoalsView: View {
    let methodologies: [MethodologyValues] = [
        MethodologyValues(tag: 4, images: EnumMethodology.imageFour.rawValue, title: EnumMethodology.titleFour.rawValue, description: EnumMethodology.descriptionFour.rawValue, example: EnumMethodology.exampleFour.rawValue),
        MethodologyValues(tag: 5, images: EnumMethodology.imageFive.rawValue, title: EnumMethodology.titleFive.rawValue, description: EnumMethodology.descriptionFive.rawValue, example: EnumMethodology.exampleFive.rawValue)
        ]
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(methodologies, id: \.self) { methodology in
                VStack(alignment: .leading) {
                    HStack {
                        Image(methodology.images)
                            .padding(.horizontal)
                        Text(methodology.title)
                            .font(.custom(EnumFonts.semibold.rawValue, size: 17))
                    }
                    Text(methodology.description)
                        .lineLimit(2, reservesSpace: true)
                        .padding(.horizontal)
                        .padding(.bottom)
                        .font(.custom(EnumFonts.regular.rawValue, size: 16))
                    Text(methodology.example)
                        .lineLimit(2, reservesSpace: true)
                        .padding(.horizontal)
                        .font(.custom(EnumFonts.light.rawValue, size: 16))
                        .foregroundColor(Color(EnumColors.subtitle.rawValue))
                    Rectangle()
                        .frame(height: 1.0, alignment: .bottom)
                        .foregroundColor(Color(EnumColors.subtitle.rawValue))
                        .padding()
                }
            }
            NavigationLink(destination:
                            SettingsView()
            ) {
                Text(EnumButtonText.close.rawValue)
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color(EnumColors.buttonColor.rawValue) )
                    .cornerRadius(13)
                    .padding()
            }
        }
            .navigationTitle("Método 52 semanas")
            .font(.custom(EnumFonts.semibold.rawValue, size: 17))
            .navigationBarTitleDisplayMode(.automatic)
            .background(Color(EnumColors.backgroundScreen.rawValue))

    }
}

struct MethodologyGoalsView_Previews: PreviewProvider {
    static var previews: some View {
        MethodologyGoalsView()
    }
}

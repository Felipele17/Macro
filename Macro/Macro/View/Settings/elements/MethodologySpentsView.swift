//
//  MethodologyView.swift
//  Macro
//
//  Created by Gabriele Namie on 27/10/22.
//

import SwiftUI

struct MethodologySpentsView: View {
    
    let methodologies: [MethodologyValues] = [
        MethodologyValues(tag: 0, images: EnumMethodology.imageOne.rawValue, title: EnumMethodology.titleOne.rawValue, description: EnumMethodology.descriptionOne.rawValue, example: EnumMethodology.exampleOne.rawValue),
        MethodologyValues(tag: 1, images: EnumMethodology.imageTwo.rawValue, title: EnumMethodology.titleTwo.rawValue, description: EnumMethodology.descriptionTwo.rawValue, example: EnumMethodology.exampleTwo.rawValue),
        MethodologyValues(tag: 2, images: EnumMethodology.imageThree.rawValue, title: EnumMethodology.titleThree.rawValue, description: EnumMethodology.descriptionThree.rawValue, example: EnumMethodology.exampleThree.rawValue)
        ]

    var body: some View {
        NavigationView {
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
                            .padding(.horizontal)
                            .padding(.bottom)
                            .font(.custom(EnumFonts.regular.rawValue, size: 16))
                        Text(methodology.example)
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
                    MethodologyGoalsView()
                ) {
                    Text(EnumButtonText.nextButton.rawValue)
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color(EnumColors.buttonColor.rawValue) )
                        .cornerRadius(13)
                        .padding()
                }
            }
                .navigationTitle("Método 50-15-35")
                .font(.custom(EnumFonts.semibold.rawValue, size: 17))
                .navigationBarTitleDisplayMode(.automatic)
                .background(Color(EnumColors.backgroundScreen.rawValue))

        }
    }
}
struct MethodologyView_Previews: PreviewProvider {
    static var previews: some View {
        MethodologySpentsView()
    }
}

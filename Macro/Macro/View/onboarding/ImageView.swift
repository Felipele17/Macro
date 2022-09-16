//
//  ImageView.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 14/09/22.
//

import SwiftUI

struct ImageView: View {
    
    let onboarding: OnBoarding
    
    var body: some View {
             
        VStack {
            if onboarding.tag != 2 {
                Image(self.onboarding.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Text(onboarding.title)
                    .fontWeight(.bold)
                
                Text(onboarding.description)
                    .frame(alignment: .bottomLeading)
                
                Spacer()
            } else { // textfield renda mensal
                Text(onboarding.title)
                    .fontWeight(.bold)
                Text(onboarding.description)
                    .frame(alignment: .bottomLeading)
                Spacer()
                Image(self.onboarding.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
    
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(onboarding: OnBoarding(imageName: "noz", title: "título", description: "descrição", tag: 0))
    }
}

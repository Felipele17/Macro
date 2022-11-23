//
//  SafetyView.swift
//  Macro
//
//  Created by Gabriele Namie on 23/11/22.
//

import SwiftUI

struct SafetyView: View {
    var body: some View {
        ZStack {
            Color(EnumColors.backgroundScreen.rawValue)
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "lock")
                        .foregroundColor(Color(EnumSpentsinfo.priorityColor.rawValue))
                    Text("Como funciona?")
                        .font(.custom(EnumFonts.semibold.rawValue, size: 20))
                        .foregroundColor(Color(EnumColors.title.rawValue))
                }.padding()
                Text("Fique tranquilo, o aplicativo conta com uma autenticação de ambas as partes para que o acesso seja restrito somente a vocês dois.")
                    .font(.custom(EnumFonts.regular.rawValue, size: 17))
                    .foregroundColor(Color(EnumColors.title.rawValue))
                    .padding()
                Text("Seus dados estão seguros!")
                    .font(.custom(EnumFonts.semibold.rawValue, size: 17))
                    .foregroundColor(Color(EnumColors.title.rawValue))
                    .padding()
                Image("Iphone")
                    .padding()
                    .frame(width: UIScreen.screenHeight/2.3, height: UIScreen.screenHeight/2.4)
            }
        }
            .navigationTitle("Segurança")
            .font(.custom(EnumFonts.semibold.rawValue, size: 34))
            .navigationBarTitleDisplayMode(.large)
    }
}

struct SafetyView_Previews: PreviewProvider {
    static var previews: some View {
        SafetyView()
    }
}

//
//  ModalView.swift
//  Macro
//
//  Created by Gabriele Namie on 07/10/22.
//

import SwiftUI

s

struct ModalView: View {
    var body: some View {
        VStack {
            ForEach(0..<3) { _ in
                HStack {
                    ForEach(0..<6) { _ in
                        Text("oi")
                        
                    }.frame(width: UIScreen.screenWidth/7, height: UIScreen.screenWidth/7)
                        .background(                Color(EnumColors.essenciaisColor.rawValue))
                            .cornerRadius(10)

                }
            }.listRowBackground(Color.clear)
        }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView()
    }
}

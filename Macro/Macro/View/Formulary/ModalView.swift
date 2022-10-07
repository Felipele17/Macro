//
//  ModalView.swift
//  Macro
//
//  Created by Gabriele Namie on 07/10/22.
//

import SwiftUI

struct ModalView: View {
    @State var icons = ["car.fill", "books.vertical.fill", "house.fill", "iphone", "airplane", "pawprint.fill", "cart.fill"]
    let columns = [
            GridItem(.adaptive(minimum: 56))
        ]

    var body: some View {
//        VStack {
//            ForEach(icons, id: \.self) { icon in
//                HStack {
        LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(icons, id: \.self) { icon in
                        Button {
                            print("oi")
                        } label: {
                            Label("", systemImage: icon)
                            .foregroundColor(Color(.white))
                            .font(.custom("SFProText-Regular", size: 22))
                            .padding(.leading, 8)
                            
                        }
   
                    }.frame(width: UIScreen.screenWidth/7, height: UIScreen.screenWidth/7)
                        .background(                Color(EnumColors.essenciaisColor.rawValue))
                            .cornerRadius(10)

        }.padding(.leading)
            .padding(.trailing)
            .listRowBackground(Color.clear)
            }
        }
//    }
//}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView()
    }
}

//
//  ModalView.swift
//  Macro
//
//  Created by Gabriele Namie on 07/10/22.
//

import SwiftUI

struct ModalView: View {
    @Binding var selectedIcon: String
    var icons = ["car.fill", "books.vertical.fill", "house.fill", "iphone", "airplane", "pawprint.fill", "cart.fill"]
    let columns = [
            GridItem(.adaptive(minimum: 56))
        ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(icons, id: \.self) { icon in
                        Button {
                            selectedIcon = icon
                        } label: {
                            Label("", systemImage: icon)
                            .foregroundColor(Color(.white))
                            .font(.custom("SFProText-Regular", size: 22))
                            .padding(.leading, 8)
                            
                        }.frame(width: UIScreen.screenWidth/7, height: UIScreen.screenWidth/7)
                            .background(selectedIcon == icon ? Color(EnumColors.buttonColor.rawValue) : Color(EnumColors.essenciaisColor.rawValue))
                            .cornerRadius(10)
                        
                    }
                        
        }.padding(.leading)
            .padding(.trailing)
            .listRowBackground(Color.clear)
        
            }
        }

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(selectedIcon: .constant("car.fill"))
    }
}

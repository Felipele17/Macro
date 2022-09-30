//
//  SpentView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct SpentView: View {
    var body: some View {
        VStack (alignment: .leading){
            Text("Gasto atual")
                .font(.custom(EnumFonts.bold.rawValue, size: 22))
            //.frame(maxWidth: .infinity, alignment: .leading)
            //.padding([.leading, .top])
            Text("R$ 1470,00")
                .font(.custom(EnumFonts.bold.rawValue, size: 28))
            //.frame(maxWidth: .infinity, alignment: .leading)
            //.padding(.leading)
            Text("Limite disponivel R$ 530,00")
                .font(.custom(EnumFonts.regular.rawValue, size: 17))
            //.frame(maxWidth: .infinity, alignment: .leading)
            //.padding(.top)
            HStack {
                Text("Gasto Essenciais")
                    .font(.custom(EnumFonts.bold.rawValue, size: 28))
                Button {
                    print("add gasto")
                } label: {
                    Label("", systemImage: "plus")
                        .foregroundColor(Color(EnumColors.ButtonColor.rawValue))
                    //.padding(.leading, 48)
                }
                
            }
            //.frame(maxWidth: .infinity, alignment: .leading)
            //.padding(.leading)
            List {
                SpentsDetailsCardView()
                SpentsDetailsCardView()
                SpentsDetailsCardView()
                SpentsDetailsCardView()
            }
            .padding(.trailing)
        }
        .padding(.leading, 20)
        .navigationTitle("Essencial")
        .font(.custom(EnumFonts.semibold.rawValue, size: 17))
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(EnumColors.ButtonUnselect.rawValue))
        //            .toolbar {
        //                Button(role: nil) {
        //                    print("editar")
        //                } label: {
        //                    Text("editar")
        //                        .font(.custom(EnumFonts.regular.rawValue, size: 17))
        //                        .tint(.blue)
        //                }
        //            }
    }
        
}

struct SpentView_Previews: PreviewProvider {
    static var previews: some View {
        SpentView()
    }
}

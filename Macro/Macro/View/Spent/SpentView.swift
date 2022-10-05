//
//  SpentView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct SpentView: View {
    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {
                Text("Gasto atual")
                    .font(.custom(EnumFonts.bold.rawValue, size: 22))
                    .padding(.top)
                Text("R$ 1470,00")
                    .font(.custom(EnumFonts.bold.rawValue, size: 28))
                Text("Limite disponivel R$ 530,00")
                    .font(.custom(EnumFonts.regular.rawValue, size: 17))
                HStack {
                    Text("Gasto Essenciais")
                        .font(.custom(EnumFonts.bold.rawValue, size: 28))
                    Spacer()
                    NavigationLink(destination: FormsSpents(viewModel: SpentViewModel(categoryPercent: EnumCategoryPercent.work))) {
                        Label("", systemImage: "plus")
                            .padding(.trailing, 35)
                            .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                    }
                }
                .padding(.top, 10)
                List {
                    SpentsDetailsCardView()
                    SpentsDetailsCardView()
                    SpentsDetailsCardView()
                    SpentsDetailsCardView()
                }
                .offset()
                
            }
            .padding(.leading)
            .background(Color(EnumColors.backgroundExpenseColor.rawValue))
            .navigationTitle("Essencial")
            .font(.custom(EnumFonts.semibold.rawValue, size: 17))
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
    
}

struct SpentView_Previews: PreviewProvider {
    static var previews: some View {
        SpentView()
    }
}

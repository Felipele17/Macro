//
//  SpentView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct SpentView: View {
    @State var isActive: Bool = false
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
                    NavigationLink(destination: FormsSpentsView(viewModel: SpentViewModel(categoryPercent: EnumCategoryPercent.work), popToView: $isActive), isActive: $isActive) {
                        Label("", systemImage: "plus")
                            .padding(.trailing, 35)
                            .foregroundColor(Color(EnumColors.ButtonColor.rawValue))
                    }
                }
                .padding(.top, 10)
                List {
                    SpentsDetailsCardView(spent: Spent(title: "Carro", value: 33.0, icon: "carro", date: Date(), categoryPercent: EnumCategoryPercent.work), viewModel: SpentViewModel(categoryPercent: EnumCategoryPercent.work))
                }
                .offset()
                
            }
            .padding(.leading)
            .background(Color(EnumColors.BackgroundExpenseColor.rawValue))
            .navigationTitle("Essencial")
            .font(.custom(EnumFonts.semibold.rawValue, size: 17))
            .navigationBarTitleDisplayMode(.inline)
        }.navigationBarHidden(true)
    }
}

struct SpentView_Previews: PreviewProvider {
    static var previews: some View {
        SpentView()
    }
}

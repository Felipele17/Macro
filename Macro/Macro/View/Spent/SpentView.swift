//
//  SpentView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct SpentView: View {
    var spentsCard: SpentsCard
    @State var spents: [Spent]
    @State var isActive: Bool = false
    var body: some View {
            VStack(alignment: .leading) {
                Text("Gasto atual")
                    .font(.custom(EnumFonts.bold.rawValue, size: 22))
                    .padding(.top)
                    .padding(.leading)
                Text("\(spentsCard.moneySpented)".floatValue.currency)
                    .font(.custom(EnumFonts.bold.rawValue, size: 28))
                    .padding(.leading)
                Text("Limite disponivel "+"\(spentsCard.avalibleMoney)".floatValue.currency)
                    .font(.custom(EnumFonts.regular.rawValue, size: 17))
                    .padding(.leading)
                HStack {
                    Text("Gasto Essenciais")
                        .font(.custom(EnumFonts.bold.rawValue, size: 28))
                    Spacer()
                    NavigationLink(destination: FormsSpentsView(viewModel: SpentViewModel(spent: Spent.emptyMock(category: spentsCard.valuesPercent)), arraySpents: $spents, colorIcon: spentsCard.colorName, isPost: true)) {
                        Label("", systemImage: "plus")
                            .padding(.trailing, 35)
                            .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                    }
                }
                .padding(.leading)
                .padding(.top, 20)
            List {
                ForEach($spents) { spent in
                    SpentsDetailsCardView(categoty: spentsCard.valuesPercent, colorIcon: spentsCard.colorName, arraySpents: $spents, spent: spent)
                }
            } .listStyle(.insetGrouped)
        }
        .navigationTitle(spentsCard.namePercent)
        .font(.custom(EnumFonts.semibold.rawValue, size: 17))
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(EnumColors.backgroundScreen.rawValue))
    }
}

//struct SpentView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            SpentView(title: "tá de palhaçada", colorIcon: EnumColors.backgroundCardMetaColor.rawValue, moneySpented: 100
//                      ,moneyAvalible: 2, spents: [Spent(title: "", value: 1, icon: "", date: Date(), categoryPercent: EnumCategoryPercent.work.rawValue)])
//        }
//    }
//}

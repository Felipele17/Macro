//
//  SpentView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct SpentView: View {
    @EnvironmentObject var viewModel: SpentViewModel
    var spentsCard: SpentsCard
    
    var body: some View {
            VStack(alignment: .leading) {
                Text("Gasto atual")
                    .font(.custom(EnumFonts.bold.rawValue, size: 22))
                    .padding(.top)
                    .padding(.leading)
                Text("\(spentsCard.moneySpented)".floatValue.currency)
                    .font(.custom(EnumFonts.bold.rawValue, size: 28))
                    .padding(.leading)
                Text("Limite disponivel "+"\(spentsCard.availableMoney)".floatValue.currency)
                    .font(.custom(EnumFonts.regular.rawValue, size: 17))
                    .padding(.leading)
                HStack {
                    Text("Gasto Essenciais")
                        .font(.custom(EnumFonts.bold.rawValue, size: 28))
                    Spacer()
                    NavigationLink {
                        FormsSpentsView(
                            spentsCard: spentsCard,
                            colorIcon: spentsCard.colorName, isPost: true)
                    } label: {
                        Label("", systemImage: "plus")
                            .padding(.trailing, 35)
                            .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                    }
                }
                .padding(.leading)
                .padding(.top, 20)
            List {
                ForEach(viewModel.getArraySpents(spentsCard: spentsCard)) { spent in
                    SpentsDetailsCardView(spent: spent, spentsCard: spentsCard)
                }
            } .listStyle(.insetGrouped)
        }
        .navigationTitle(spentsCard.namePercent)
        .font(.custom(EnumFonts.semibold.rawValue, size: 17))
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(EnumColors.backgroundScreen.rawValue))

    }
}

// struct SpentView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            SpentView(title: "tá de palhaçada", colorIcon: EnumColors.backgroundCardMetaColor.rawValue, moneySpented: 100
//                      ,moneyAvalible: 2, spents: [Spent(title: "", value: 1, icon: "", date: Date(), categoryPercent: EnumCategoryPercent.work.rawValue)])
//        }
//    }
// }

//
//  SpentView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct SpentView: View {
    @ObservedObject var viewModel: SpentViewModel
    
    var body: some View {
            VStack(alignment: .leading) {
                Text("Gasto atual")
                    .font(.custom(EnumFonts.bold.rawValue, size: 22))
                    .padding(.top)
                    .padding(.leading)
                Text("\(viewModel.spentsCard.wrappedValue.moneySpented)".floatValue.currency)
                    .font(.custom(EnumFonts.bold.rawValue, size: 28))
                    .padding(.leading)
                Text("Limite disponivel "+"\(viewModel.spentsCard.wrappedValue.avalibleMoney)".floatValue.currency)
                    .font(.custom(EnumFonts.regular.rawValue, size: 17))
                    .padding(.leading)
                HStack {
                    Text("Gasto Essenciais")
                        .font(.custom(EnumFonts.bold.rawValue, size: 28))
                    Spacer()
                    NavigationLink(destination:
                                    FormsSpentsView(spent: .constant(Spent.emptyMock(category: viewModel.spentsCard.wrappedValue.valuesPercent)), value: 0.0, colorIcon: viewModel.spentsCard.wrappedValue.colorName, isPost: true)
                                        .environmentObject(viewModel)
                    ) {
                        Label("", systemImage: "plus")
                            .padding(.trailing, 35)
                            .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                    }
                }
                .padding(.leading)
                .padding(.top, 20)
            List {
                ForEach(viewModel.arraySpents) { spent in
                    SpentsDetailsCardView(spent: spent, colorIcon: viewModel.spentsCard.wrappedValue.colorName)
                        .environmentObject(viewModel)
                }
            } .listStyle(.insetGrouped)
        }
        .navigationTitle(viewModel.spentsCard.wrappedValue.namePercent)
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

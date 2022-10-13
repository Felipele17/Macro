//
//  SpentView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct SpentView: View {
    var title: String
    @State var isActive: Bool = false
    var colorIcon: String
    var body: some View {
            VStack(alignment: .leading) {
                Text("Gasto atual")
                    .font(.custom(EnumFonts.bold.rawValue, size: 22))
                    .padding(.top)
                    .padding(.leading)
                Text("R$ 1470,00")
                    .font(.custom(EnumFonts.bold.rawValue, size: 28))
                    .padding(.leading)
                Text("Limite disponivel R$ 530,00")
                    .font(.custom(EnumFonts.regular.rawValue, size: 17))
                    .padding(.leading)
                HStack {
                    Text("Gasto Essenciais")
                        .font(.custom(EnumFonts.bold.rawValue, size: 28))
                    Spacer()
                    NavigationLink(destination: FormsSpentsView(viewModel: SpentViewModel(spent: Spent.emptyMock(category: title)), isPost: true, categoty: title)) {
                        Label("", systemImage: "plus")
                            .padding(.trailing, 35)
                            .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                    }
                }
                .padding(.leading)
                .padding(.top, 20)
            List {
                ForEach(0 ..< $spents.count) { ind in
                    SpentsDetailsCardView(categoty: title, viewModel: SpentViewModel(spent: spents[ind]))
                }
            } .listStyle(.insetGrouped)
        }
        .navigationTitle(title)
        .font(.custom(EnumFonts.semibold.rawValue, size: 17))
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(EnumColors.backgroundScreen.rawValue))
    }
}

struct SpentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SpentView(title: .constant("tá de palhaçada"), spents: [Spent(title: "", value: 1, icon: "", date: Date(), categoryPercent: EnumCategoryPercent.work.rawValue)])
        }
    }
}

//
//  SpentsDetailsCardView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct SpentsDetailsCardView: View {
    var categoty: String
    @State var isActive = false
    var spent: Spent
    var colorIcon: String
    @StateObject var viewModel: SpentViewModel

    var body: some View {
        NavigationLink(isActive: $isActive) {
            FormsSpentsView(viewModel: viewModel, isPost: false, categoty: categoty)
        } label: {
            HStack {
                ZStack {
                    Color(EnumColors.essenciaisColor.rawValue)
                        .cornerRadius(10)
                    Image(systemName: viewModel.spent.icon)
                        .foregroundColor(.white)
                }.frame(width: UIScreen.screenWidth/9, height: UIScreen.screenWidth/9)
                VStack(alignment: .leading) {
                    Text(viewModel.spent.title)
                        .font(.custom(EnumFonts.medium.rawValue, size: 17))
                    Text(viewModel.spent.date.description)
                        .font(.custom(EnumFonts.light.rawValue, size: 13))
                }.padding(.leading, 4)
                Spacer()
                Text("R$\(viewModel.spent.value)")
                    .font(.custom(EnumFonts.medium.rawValue, size: 20))
                    .padding(.vertical)
            }
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false ) {
            Button {
                viewModel.deleteSpent(spent: viewModel.spent)
            } label: {
                Label("Deletar", systemImage: "trash.fill")
            }
        }
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            Button {
                isActive.toggle()
            } label: {
                Label("Editar", systemImage: "square.and.pencil")
            }
        }
    }
}

struct SpentsDetailsCardView_Previews: PreviewProvider {
    static var previews: some View {
        SpentsDetailsCardView(categoty: EnumCategoryPercent.work.rawValue, viewModel: SpentViewModel(spent: Spent.emptyMock(category: EnumCategoryPercent.work.rawValue)))
    }
}

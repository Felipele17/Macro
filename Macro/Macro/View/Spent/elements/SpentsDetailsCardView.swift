//
//  SpentsDetailsCardView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct SpentsDetailsCardView: View {
    var categoty: Int
    @State var isActive = false
    var colorIcon: String
    @StateObject var viewModel: SpentViewModel

    var body: some View {
        NavigationLink(isActive: $isActive) {
            FormsSpentsView(viewModel: viewModel, colorIcon: colorIcon, isPost: false)
        } label: {
            HStack {
                ZStack {
                    Color(colorIcon)
                        .cornerRadius(10)
                    Image(systemName: viewModel.spent.icon)
                        .foregroundColor(.white)
                }.frame(width: UIScreen.screenWidth/9, height: UIScreen.screenWidth/9)
                VStack(alignment: .leading) {
                    Text(viewModel.spent.title)
                        .font(.custom(EnumFonts.medium.rawValue, size: 17))
                    Text(viewModel.spent.date.formatted(date: .numeric, time: .omitted).description)
                        .font(.custom(EnumFonts.light.rawValue, size: 13))
                        
                }.padding(.leading, 4)
                Spacer()
                Text("\(viewModel.spent.value)".floatValue.currency)
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
        SpentsDetailsCardView(
            categoty: 50,
            colorIcon: EnumColors.backgroundCardMetaColor.rawValue,
            viewModel: SpentViewModel(spent: Spent.emptyMock(category: 50))
        )
    }
}

//
//  SpentsDetailsCardView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct SpentsDetailsCardView: View {
    @State var viewModel = SpentCarViewModel()
    var categoty: Int
    @State var isActive = false
    var colorIcon: String
    @Binding var arraySpents: [Spent]
    @Binding var spent: Spent

    var body: some View {
        NavigationLink(isActive: $isActive) {
            FormsSpentsView(viewModel: SpentViewModel(spent: spent), arraySpents: $arraySpents, title: spent.title, icon: spent.icon, value: spent.value, date: spent.date, colorIcon: colorIcon, isPost: false)
        } label: {
            HStack {
                ZStack {
                    Color(colorIcon)
                        .cornerRadius(10)
                    Image(systemName: spent.icon)
                        .foregroundColor(.white)
                }.frame(width: UIScreen.screenWidth/9, height: UIScreen.screenWidth/9)
                VStack(alignment: .leading) {
                    Text(spent.title)
                        .font(.custom(EnumFonts.medium.rawValue, size: 17))
                    Text(spent.date.description)
                        .font(.custom(EnumFonts.light.rawValue, size: 13))
                }.padding(.leading, 4)
                Spacer()
                Text("\(spent.value)".floatValue.currency)
                    .font(.custom(EnumFonts.medium.rawValue, size: 20))
                    .padding(.vertical)
            }
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false ) {
            Button {
                viewModel.deleteSpent(spent: spent)
                arraySpents.removeAll { spent in
                    spent.idName == self.spent.idName
                }
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
            categoty: 50, colorIcon: EnumColors.backgroundCardMetaColor.rawValue,
            arraySpents: .constant([Spent.emptyMock(category: 50), Spent.emptyMock(category: 50)]),
            spent: .constant(Spent.emptyMock(category: 50))
        )
    }
}

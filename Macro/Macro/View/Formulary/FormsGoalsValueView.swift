//
//  FormsGoalsValueView.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 28/09/22.
//

import SwiftUI

struct FormsGoalsValueView: View {
    
    @State var moneyField: String = ""
    @State private var pageIndex = 1
    
    @FocusState var keyboardIsFocused: Bool
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Quanto você deseja guardar?")
                .font(.custom("SFProText-Medium", size: 34))
                .padding(1)
            Text("Depositando R$ 1 por semana de forma gradual, em 52 semanas você irá ter em sua conta R$ 1.378,00")
                .padding(10)
            TextField("Ex.: R$ 1.378,00", text: $moneyField)
                .keyboardType(.decimalPad)
                .focused($keyboardIsFocused)
                .underlineTextField()
                .padding(5)
            Text("Nível de Prioridade")
                .font(.custom(EnumFonts.medium.rawValue, size: 28))
                .padding(.top, 30)
            HStack {
                VStack {
                    Image("Noz1")
                    Text("Pequena")
                }
                Spacer()
                VStack {
                    Image("Noz2")
                    Text("Média")
                }
                Spacer()
                VStack {
                    Image("Noz3")
                    Text("Grande")
                }
            }
            .padding(10)
            Spacer()
            LabelNextButton(text: EnumButtonText.nextButton.rawValue, textField: $moneyField, pageIndex: $pageIndex)
        }
        .padding(20)
    }
}

struct FormsGoalsValueView_Previews: PreviewProvider {
    static var previews: some View {
        FormsGoalsValueView()
    }
}

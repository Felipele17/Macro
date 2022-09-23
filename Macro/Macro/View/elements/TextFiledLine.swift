//
//  TextFiledLine.swift
//  Macro
//
//  Created by Vitor Cheung on 23/09/22.
//

import SwiftUI

struct TextFiledLine: View {
    @Binding var incomeTextField: Float
    @FocusState var keyboardIsFocused: Bool
    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()
    var body: some View {
        VStack {
            TextField("Ex.: R$ 3000,00", value: $incomeTextField, formatter: formatter)
                .keyboardType(.decimalPad)
                .foregroundColor(Color("Placeholder"))
                .focused($keyboardIsFocused)
            Rectangle()
                .frame(height: 1.0, alignment: .bottom)
                .foregroundColor(Color("Placeholder"))
                
        }
        .onReceive(viewModel.$onboardingPage, perform: { _ in
            keyboardIsFocused = false
        })
    }
}

struct TextFiledLine_Previews: PreviewProvider {
    static var previews: some View {
        TextFiledLine()
    }
}

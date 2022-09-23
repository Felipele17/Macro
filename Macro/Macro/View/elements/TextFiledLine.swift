//
//  TextFiledLine.swift
//  Macro
//
//  Created by Vitor Cheung on 23/09/22.
//

import SwiftUI

struct TextFiledLine: View {
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
    }
}

struct TextFiledLine_Previews: PreviewProvider {
    static var previews: some View {
        TextFiledLine()
    }
}

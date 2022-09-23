//
//  FormsSpends.swift
//  Macro
//
//  Created by Gabriele Namie on 23/09/22.
//

import SwiftUI

struct FormView: View {
    
    @State var incomeTextField: Float
    @FocusState var keyboardIsFocused: Bool
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("Nome")
                TextField("Ex: Luz", value: $incomeTextField, formatter: formatter)
                    .keyboardType(.default)
                    .foregroundColor(.green)
                    .focused($keyboardIsFocused)
                Rectangle()
                    .frame(height: 1.0, alignment: .bottom)
                    .foregroundColor(.green)
            }
            
            Group {
                Text("Ícone")
                TextField("Ex: ", value: $incomeTextField, formatter: formatter)
                    .foregroundColor(.green)
                    .focused($keyboardIsFocused)
                Rectangle()
                    .frame(height: 1.0, alignment: .bottom)
                    .foregroundColor(.green)
            }
            
            Group {
                Text("Valor (R$)")
                TextField("Ex: 100,00", value: $incomeTextField, formatter: formatter)
                    .keyboardType(.decimalPad)
                    .foregroundColor(.green)
                    .focused($keyboardIsFocused)
                Rectangle()
                    .frame(height: 1.0, alignment: .bottom)
                    .foregroundColor(.green)
            }
            
            Group {
                Text("Data")
                TextField("Ex: 23/09/2022", value: $incomeTextField, formatter: formatter)
                    .keyboardType(.decimalPad)
                    .foregroundColor(.green)
                    .focused($keyboardIsFocused)
                Rectangle()
                    .frame(height: 1.0, alignment: .bottom)
                    .foregroundColor(.green)
            }
            
        }
        
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView(incomeTextField: 4.0)
    }
}

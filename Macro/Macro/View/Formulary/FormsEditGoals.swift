//
//  FormsEditGoals.swift
//  Macro
//
//  Created by Gabriele Namie on 28/09/22.
//

import SwiftUI

struct FormsEditGoals: View {
    @State private var nameGoal = ""
    @State private var valueGoal = ""
    
    var body: some View {
        Form {
            Section(header: Text("Nome").foregroundColor(Color("Title")).font(.custom("SFProText-Regular", size: 22))) {
                TextField("Ex: Luz", text: $nameGoal)
                    .underlineTextField()
                    .listRowBackground(Color.clear)
            }.textCase(.none)
            
            Section(header: Text("Valor(R$)").foregroundColor(Color("Title")).font(.custom("SFProText-Regular", size: 22))) {
                TextField("Ex: R$500,00", text: $valueGoal)
                    .underlineTextField()
                    .keyboardType(.decimalPad)
                    .listRowBackground(Color.clear)
            }.textCase(.none)
        }.navigationBarTitle("Editar", displayMode: .inline)
            .toolbar {
                Button("Salvar") {
                }
            }
    }
}

struct FormsEditGoals_Previews: PreviewProvider {
    static var previews: some View {
        FormsEditGoals()
    }
}

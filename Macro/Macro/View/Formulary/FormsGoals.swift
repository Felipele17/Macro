//
//  FormsGoals.swift
//  Macro
//
//  Created by Gabriele Namie on 23/09/22.
//

import SwiftUI

struct FormsGoals: View {
    
    @State private var goalField: String = ""
    @State private var pageIndex = 0
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Qual o nome da sua meta?")
                    .font(.custom("SFProText-Medium", size: 34))
                    .padding(1)
                Text("Coloque um nome que te lembre de alcançar esta meta")
                    .padding(10)
                TextField("Ex.: Carro novo", text: $goalField)
                    .underlineTextField()
                    .padding(5)
                Spacer()
                LabelNextButton(text: EnumButtonText.nextButton.rawValue, textField: $goalField, pageIndex: $pageIndex)
            }
            .padding(20)
        }
    }
}

struct FormGoalsView_Previews: PreviewProvider {
    static var previews: some View {
        FormsGoals()
    }
}

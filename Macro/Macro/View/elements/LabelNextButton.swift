//
//  LabelNextButton.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 28/09/22.
//

import SwiftUI

struct LabelNextButton: View {
    
    var text: String
    @Binding var textField: String
    @Binding var pageIndex: Int
    
    var body: some View {
        
        NavigationLink {
            // changing the view
            switch pageIndex {
            case 0:
                FormsGoalsValueView()
            case 1:
                MotivationView()
            default:
                MotivationView()
            }
            
        } label: {
            Text(text)
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(textField.isEmpty ? .gray : .blue)
                .cornerRadius(13)
        }

    }
}

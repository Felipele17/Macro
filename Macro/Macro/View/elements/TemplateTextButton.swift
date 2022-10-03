//
//  TextButton.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 29/09/22.
//

import SwiftUI

struct TemplateTextButton: View {
    
    var text: String
    var isTextFieldEmpty: Bool
    
    var body: some View {
        Text(text)
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(isTextFieldEmpty ? .gray : .blue)
            .cornerRadius(13)
    }
}

struct TextButton_Previews: PreviewProvider {
    static var previews: some View {
        TemplateTextButton(text: "", isTextFieldEmpty: false)
    }
}

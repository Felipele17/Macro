//
//  PickerSegmentedView.swift
//  Macro
//
//  Created by Gabriele Namie on 06/10/22.
//

import SwiftUI

struct PickerSegmentedView: View {
    @Binding var selectFilter: Int
    init(selectFilter: Binding<Int>) {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color(EnumColors.buttonColor.rawValue))
           UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color(EnumColors.title.rawValue))], for: .normal)
        self._selectFilter = selectFilter
    }
    var body: some View {
        Picker("Qual filtro voce?", selection: $selectFilter) {
            Text("Todos").tag(0)
                .font(.custom(EnumFonts.medium.rawValue, size: 13))
            Text("À depositar").tag(1)
                .font(.custom(EnumFonts.medium.rawValue, size: 13))
                
            Text("Depositado").tag(2)
                .font(.custom(EnumFonts.medium.rawValue, size: 13))
        }
        .pickerStyle(.segmented)
        .padding([.leading, .trailing, .top])
    }
}

struct PickerSegmentedView_Previews: PreviewProvider {
    static var previews: some View {
        PickerSegmentedView(selectFilter: .constant(3))
    }
}

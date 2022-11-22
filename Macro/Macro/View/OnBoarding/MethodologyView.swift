//
//  MethodologyView.swift
//  Macro
//
//  Created by Gabriele Namie on 04/11/22.
//

import SwiftUI

struct MethodologyView: View {
    private let dotAppearance = UIPageControl.appearance()
    var body: some View {
        VStack {
            TabView {
                
            }
        }.onAppear {
            dotAppearance.currentPageIndicatorTintColor = UIColor(Color(EnumColors.dotAppearing.rawValue))
            dotAppearance.pageIndicatorTintColor = UIColor(Color(EnumColors.dotNotAppearing.rawValue))
        }
    }
}

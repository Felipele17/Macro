//
//  LaunchScreenView.swift
//  Macro
//
//  Created by Gabriele Namie on 19/10/22.
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        ZStack {
            Color(EnumColors.backgroundLaunchScreen.rawValue)
                .ignoresSafeArea()
            LaunchScreen(name: "launchScreen", loopMode: .loop)
            
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}

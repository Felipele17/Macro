//
//  LaunchScreenView.swift
//  Macro
//
//  Created by Gabriele Namie on 19/10/22.
//

import SwiftUI

struct LaunchScreenView: View {
    @State private var scaleFactor: CGFloat = 1.0
    var body: some View {
        ZStack {
            Color(EnumColors.backgroundLaunchScreen.rawValue) .ignoresSafeArea()
            Image("NozLaunch")
         //       .blur(radius: 2.0)
                .onAppear(perform: {
                           self.scaleFactor = 2.0
                       })
                .scaleEffect(scaleFactor)
           //     .scaleEffect(.blur(radius: 1.0))
                .animation(
                    Animation.easeInOut(duration: 3)
                        .repeatForever(autoreverses: true))
                
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}

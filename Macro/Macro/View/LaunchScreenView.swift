//
//  LaunchScreenView.swift
//  Macro
//
//  Created by Gabriele Namie on 19/10/22.
//

import SwiftUI
import Lottie

struct LaunchScreenView: View {
    @Environment (\.presentationMode) var presentationMode: Binding <PresentationMode>
    @State private var scaleFactor: CGFloat = 1.0
    @State var show = false
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
                
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}

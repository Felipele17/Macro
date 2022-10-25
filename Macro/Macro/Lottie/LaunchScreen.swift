//
//  LaunchScreen.swift
//  Macro
//
//  Created by Gabriele Namie on 24/10/22.
//

import SwiftUI
import Lottie

struct LaunchScreen: UIViewRepresentable {
    var name = "launchScreen"
    var loopMode: LottieLoopMode = .loop

    func makeUIView(context: UIViewRepresentableContext<LaunchScreen>) -> UIView {
        let view = UIView(frame: .zero)

        let animationView = LottieAnimationView()
        let animation = Animation.named(name)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen(name: "launchScreen", loopMode: .loop)
    }
}

// struct LaunchScreen: UIViewRepresentable {
//    let lottieFile: String
//    let animationView = LottieAnimationView()
//
//    func makeUIView(context: Context) -> some UIView {
//        let view = UIView(frame: .zero)
//
//        animationView.animation = Animation.named(lottieFile)
//        animationView.contentMode = .scaleAspectFit
//        animationView.play()
//
//        view.addSubview(animationView)
//
//        animationView.translatesAutoresizingMaskIntoConstraints = false
//        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
//        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//
//        return view
//    }
//
//    func updateUIView(_ uiView: UIViewType, context: Context) {
//    }
//}

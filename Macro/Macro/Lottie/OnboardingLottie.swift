//
//  OnboardingLottie.swift
//  Macro
//
//  Created by Gabriele Namie on 23/11/22.
//

import SwiftUI
import Lottie

struct OnboardingLottie: UIViewRepresentable {
    var name = "onboardingFlow"
    var loopMode: LottieLoopMode = .loop

    func makeUIView(context: UIViewRepresentableContext<OnboardingLottie>) -> UIView {
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

struct OnboardingLottie_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen(name: "OnboardingFlow", loopMode: .loop)
    }
}

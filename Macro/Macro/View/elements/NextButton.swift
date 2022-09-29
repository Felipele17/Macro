//
//  NextButton.swift
//  Macro
//
//  Created by Vitor Cheung on 23/09/22.
//

import Foundation
import SwiftUI

struct NextButton: View {
    
    var text: String
    var cloud = CloudKitModel.shared
    @Binding var onboardingPage: Int
    @Binding var income: Float
    
    var body: some View {
        Button {
            if onboardingPage != 3 {
                onboardingPage += 1
            } else {
                guard let sharingController = cloud.makeUIViewControllerShare() else { return }
                let window = UIApplication.shared.keyWindow
                window?.rootViewController?.present(sharingController, animated: true)
            }
            
        } label: {
            Text(text)
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(income != 0.0 ? .blue : .gray)
                .cornerRadius(13)
        }
    }
}

extension UIApplication {
    
    public var keyWindow: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes
            // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
            // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
            // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
            // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
    
}

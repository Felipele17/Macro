//
//  ProgressBarCardView.swift
//  Macro
//
//  Created by Gabriele Namie on 20/09/22.
//

import SwiftUI

struct ProgressBarCardView: View {
    var percentsProgress: CGFloat
    var isFinished: Bool
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color(EnumColors.backgroundProgressColor.rawValue))
                    .frame(width: 220, height: 8)
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color(isFinished ? EnumColors.backgroundProgressColor.rawValue :EnumColors.foregroundProgressColor.rawValue))
                    .frame(width: percentsProgress, height: 8)
            }
        }
        .frame(width: 220, height: 8, alignment: .leading)
    }
}


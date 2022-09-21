//
//  ProgressBarCardView.swift
//  Macro
//
//  Created by Gabriele Namie on 20/09/22.
//

import SwiftUI

struct ProgressBarCardView: View {
    var currentProgress: CGFloat = 0.7
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color("BackgroundProgressColor"))
                    .frame(width: 220, height: 8)
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color("ForegroundProgressColor"))
                    .frame(width: 220*currentProgress, height: 8)
            }
        }
        .frame(width: 220, height: 8, alignment: .leading)
    }
}

struct ProgressBarCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarCardView()
    }
}

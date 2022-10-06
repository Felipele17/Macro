//
//  GoalCardView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct GoalCardView: View {
    @StateObject var viewModel = GoalCardViewModel()
    let goal: Goal
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Text(goal.title).font(.custom(EnumFonts.semibold.rawValue, size: 22))
                    .padding(.top, 2)
                Spacer()
                Image("\(viewModel.setImagebyPriority(goal: goal))")
                    .padding(.trailing)
            }
            
            Text("Motivação: ")
                .font(.custom(EnumFonts.semibold.rawValue, size: 13)) + Text(goal.motivation ?? "").font(.custom(EnumFonts.regular.rawValue, size: 13))
            Spacer()
            
            ProgressBarCardView(percentsProgress: viewModel.calc(goal: goal))
                .padding(.top, 2)
                .padding(.bottom, 2)
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text( "\(goal.getAllMoneySave())".floatValue.currency)
                        .font(.custom(EnumFonts.semibold.rawValue, size: 17))
                    + Text(" de ")
                        .font(.custom(EnumFonts.light.rawValue, size: 17))
                    + Text("   \(goal.value)".floatValue.currency)
                        .font(.custom(EnumFonts.light.rawValue, size: 17))
                    
                    Text("Faltam \(52 - goal.weeks) semanas").font(.custom(EnumFonts.regular.rawValue, size: 13))
                    
                    Spacer()
                }
                Spacer()
            }
        }
        .padding(.leading, 20)
        .padding(.top, 20)
        .foregroundColor(Color(.white))
        .background(Color(EnumColors.backgroundCardMetaColor.rawValue))
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}
extension String {
    static let numberFormatter = NumberFormatter()
    var floatValue: Float {
        String.numberFormatter.decimalSeparator = "."
        if let result =  String.numberFormatter.number(from: self) {
            return result.floatValue
        } else {
            String.numberFormatter.decimalSeparator = ","
            if let result = String.numberFormatter.number(from: self) {
                return result.floatValue
            }
        }
        return 0
    }
}
extension NumberFormatter {
    convenience init(style: Style) {
        self.init()
        self.numberStyle = style
    }
}
extension Formatter {
    static let currency = NumberFormatter(style: .currency)
}
extension FloatingPoint {
    var currency: String {
        Formatter.currency.locale = Locale(identifier: "pt_BR")
        return Formatter.currency.string(for: self) ?? ""
    }
}

struct GoalCardView_Previews: PreviewProvider {
    static var previews: some View {
        GoalCardView( goal: Goal(title: "Carro Novo", value: 5000, weeks: 48, motivation: "Realização de um sonho", priority: 1, methodologyGoal: MethodologyGoal(weeks: 52, crescent: true)))
            .previewInterfaceOrientation(.portrait)
    }
}

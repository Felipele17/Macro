//
//  MotivationView.swift
//  Macro
//
//  Created by Bianca Maciel Matos on 28/09/22.
//

import SwiftUI

struct FormsGoalMotivationView: View {
    @EnvironmentObject var viewModel: GoalViewModel
    @EnvironmentObject var pathController: PathController
    
    var motivations: [String] = ["Guardar dinheiro", "Realização de um sonho", "Sempre quis conquistar essa meta"]
    
    @State var index = 1
    @State var motivation = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Qual a motivação?")
                .font(.custom("SFProText-Medium", size: 34))
                .padding(1)
            Text("Selecione qual motivação mais se encaixa na sua meta (opcional)")
                .font(.custom("SFProText-Light", size: 15))
                .padding(10)
            
            Button {
                index = 1
                viewModel.selectedGoal.motivation = motivations[index - 1]
            } label: {
                MotivationCard(text: motivations[0])
                    .foregroundColor(index == 1 ? Color("ButtonColor") : Color("ButtonUnselect"))
                    .accentColor(index == 1 ? Color("Title") : Color("UnselectText"))
            }
            
            Button {
                index = 2
                viewModel.selectedGoal.motivation = motivations[index - 1]

            } label: {
                MotivationCard(text: motivations[1])
                    .foregroundColor(index == 2 ? Color("ButtonColor") : Color("ButtonUnselect"))
                    .accentColor(index == 2 ? Color("Title") : Color("UnselectText"))
            }
            
            Button {
                index = 3
                viewModel.selectedGoal.motivation = motivations[index - 1]

            } label: {
                MotivationCard(text: motivations[2])
                    .foregroundColor(index == 3 ? Color("ButtonColor") : Color("ButtonUnselect"))
                    .accentColor(index == 3 ? Color("Title") : Color("UnselectText"))
            }
            Spacer()
        }
        .padding(20)
        .navigationBarTitle("motivação", displayMode: .inline)
        .background(Color(EnumColors.backgroundScreen.rawValue))
        .toolbar {
            Button {
                viewModel.addGoal(goal: viewModel.selectedGoal)
                pathController.path.removeLast(pathController.path.count)
            } label: {
                Text("Salvar")
            }.foregroundColor(Color(EnumColors.buttonColor.rawValue))
        }
    }
}

// struct MotivationView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            FormsGoalMotivationView(goal: .constant(Goal(title: "", value: 1, weeks: 1, motivation: "", priority: 1, methodologyGoal: MethodologyGoal(weeks: 1, crescent: true))), popToRoot: .constant(true))
//        }
//    }
// }

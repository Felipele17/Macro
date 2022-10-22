//
//  ContentView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct GoalsView: View {
    @Binding var goal: Goal
    @Binding var goals: [Goal]
    @StateObject private var viewModel = GoalViewModel()
    @State private var selectFilter = 1
    
    var body: some View {
        VStack {
            HStack {
                Text(goal.title)
                    .font(.custom(EnumFonts.bold.rawValue, size: 34))
                    .padding()
                Spacer()
                Button(role: nil) {
                    viewModel.deleteGoal(goal: goal)
                    goals.removeAll { goal in
                        goal.id == self.goal.id
                    }
                } label: {
                    Label("", systemImage: "trash")
                        .font(.custom(EnumFonts.bold.rawValue, size: 22))
                        .foregroundColor(Color(EnumColors.foregroundGraphMetaColor.rawValue))
                }
                .padding()
            }
            ZStack {
                Color.white
                    .cornerRadius(cornerRadiusNumber())
                    .shadow(radius: cornerRadiusNumber())
                    .padding([.leading, .trailing, .bottom])
                Color(EnumColors.backgroundExpenseColor.rawValue)
                
                VStack {
                    Text("Semana \(goal.weeks)")
                        .font(.custom(EnumFonts.semibold.rawValue, size: 22))
                        .padding()
                    GraphView(chartPieViewModel: ChartPieViewModel(
                        chartDatas: [
                            ChartData(color: Color(EnumColors.foregroundGraphMetaColor.rawValue), value: CGFloat(goal.getAllMoneySave())),
                            ChartData(color: Color(EnumColors.backgroundGraphMetaColor.rawValue), value: CGFloat(goal.getNeedMoneyToCompleteGoal()))
                        ]
                    )
                    )
                    .offset(x: 0, y: UIScreen.screenHeight/35)
                }
            }
            .frame(width: UIScreen.screenHeight/2.3, height: UIScreen.screenHeight/2.5 )
            .cornerRadius(30)
            VStack {
                PickerSegmentedView(selectFilter: $selectFilter)
                List {
                    if selectFilter != 1 {
                        ForEach(goal.getArrayWeeksCheck(), id: \.self) { week in
                            WeakGoalsView(title: "Semana \(week)", valor: goal.getMoneySaveForWeek(week: week))
                     }
                    }
                    if selectFilter != 2 {
                        WeakGoalsView(title: "Semana \(goal.weeks)", valor: goal.getMoneySaveForWeek(week: goal.weeks))
                            .onTapGesture {
                                goal.weeks += 1
                                viewModel.checkWeekGoal(goal: goal)
                            }

                        ForEach(goal.getArrayWeeksNotCheck(), id: \.self) { week in
                            WeakGoalsView(title: "Semana \(week)", valor: goal.getMoneySaveForWeek(week: week))
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            NavigationLink {
                FormsEditGoals(goal: $goal)
            } label: {
                Text("Editar")
                    .font(.custom(EnumFonts.regular.rawValue, size: 17))
                    .tint(Color(EnumColors.buttonColor.rawValue))
            }
        }.foregroundColor(Color(EnumColors.buttonColor.rawValue))
        .background(Color(EnumColors.backgroundScreen.rawValue))
    }
}

extension GoalsView {
    private func cornerRadiusNumber() -> CGFloat {
        return 10
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            GoalsView(goal:
//                    .constant(Goal(title: "Novo Carro", value: 2000.00, weeks: 45, motivation: "", priority: 2, methodologyGoal: MethodologyGoal(weeks: 52, crescent: true))), goals: .constant([Goal(title: "Novo Carro", value: 2000.00, weeks: 45, motivation: "", priority: 2, methodologyGoal: MethodologyGoal(weeks: 52, crescent: true))])
//            )
//        }
//    }
//}

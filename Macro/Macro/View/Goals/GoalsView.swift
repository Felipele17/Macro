//
//  ContentView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct GoalsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding <PresentationMode>
    @EnvironmentObject var goalViewModel: GoalViewModel
    @State private var selectFilter = 1
    @State var goal: Goal
    
    var body: some View {
        VStack {
            HStack {
                Text(goal.title)
                    .font(.custom(EnumFonts.bold.rawValue, size: 34))
                    .padding()
                Spacer()
                Button(role: nil) {
                    goalViewModel.deleteGoal(goal: goal)
                    goalViewModel.goals.removeAll { goal in
                        goal.id == self.goal.id
                    }
                    self.presentationMode.wrappedValue.dismiss()
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
                        if goal.weeks != goal.methodologyGoal?.weeks {
                            WeakGoalsView(title: "Semana \(goal.weeks+1)", valor: goal.getMoneySaveForWeek(week: goal.weeks+1))
                                .onTapGesture {
                                    goalViewModel.editGoal(goal: goal)
                                    goal.weeks += 1
                                }
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
                FormsEditGoals(nameGoal: goal.title, priority: goal.priority, goal: $goal)
            } label: {
                Text("Editar")
                    .font(.custom(EnumFonts.regular.rawValue, size: 17))
                    .tint(Color(EnumColors.buttonColor.rawValue))
            }
        }.accentColor(Color(EnumColors.buttonColor.rawValue))
        .background(Color(EnumColors.backgroundScreen.rawValue))
    }
}

extension GoalsView {
    private func cornerRadiusNumber() -> CGFloat {
        return 10
    }
}

// struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            GoalsView(goal:
//                    .constant(Goal(title: "Novo Carro", value: 2000.00, weeks: 45, motivation: "", priority: 2, methodologyGoal: MethodologyGoal(weeks: 52, crescent: true))), goals: .constant([Goal(title: "Novo Carro", value: 2000.00, weeks: 45, motivation: "", priority: 2, methodologyGoal: MethodologyGoal(weeks: 52, crescent: true))])
//            )
//        }
//    }
// }

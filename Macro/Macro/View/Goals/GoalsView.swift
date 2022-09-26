//
//  ContentView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct GoalsView: View {
    var goal: Goal
    @ObservedObject private var viewModel = GoalViewModel()
    @State private var selectFilter = 1
    
    var body: some View {
        VStack {
            HStack {
                Text(goal.title)
                    .font(.title)
                    .bold()
                    .padding()
                Spacer()
                Button(role: nil) {
                    viewModel.deleteGoal(goal: goal)
                } label: {
                    Label("", systemImage: "trash")
                        .tint(.blue)
                }
                .padding()
            }
            ZStack {
                Color.white
                    .cornerRadius(cornerRadiusNumber())
                    .shadow(radius: cornerRadiusNumber())
                    .padding([.leading, .trailing, .bottom])
                VStack {
                    Text("\(goal.weeks) semanas")
                        .font(.title2)
                        .padding()
                    GraphView(chartPieViewModel: ChartPieViewModel(
                        chartDatas: [
                            ChartData(color: .green, value: CGFloat(goal.getAllMoneySave())),
                            ChartData(color: .cyan, value: CGFloat(goal.getNeedMoneyToCompleteGoal()))
                            ]
                        )
                    )
                    .offset(x: 0, y: UIScreen.screenHeight/20)
                }
            }
            .frame(height: UIScreen.screenHeight/2.5)
            .padding(.bottom)
            VStack {
                Picker("Qual filtro voce?", selection: $selectFilter) {
                    Text("Todos").tag(0)
                    Text("Á fazer").tag(1)
                    Text("Concluído").tag(2)
                }
                .pickerStyle(.segmented)
                .padding([.leading, .trailing])
                List {
                    if selectFilter != 1 {
                        ForEach(1..<goal.weeks) { week in
                            WeakGoalsView(title: "semana \(week)", valor: goal.getMoneySaveForWeek(week: week))
                                .listRowBackground(Color.indigo)
                                .colorInvert()
                        }
                    }
                    if selectFilter != 2 {
                        WeakGoalsView(title: "semana \(goal.weeks)", valor: goal.getMoneySaveForWeek(week: goal.weeks))
                            .listRowBackground(Color.red)
                            .colorInvert()
                            .onTapGesture {
                                viewModel.checkWeekGoal(goal: goal)
                            }
                        
                        ForEach(goal.weeks+1..<(goal.methodologyGoal?.weeks ?? 0)) { week in
                            WeakGoalsView(title: "semana \(week)", valor: goal.getMoneySaveForWeek(week: week))
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                Button(role: nil) {
                    print("add configuração")
                } label: {
                    Text("editar")
                        .tint(.blue)
                }
            }
        }
    }
}

extension GoalsView {
    private func cornerRadiusNumber() -> CGFloat {
        return 10
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GoalsView(goal:
                    Goal(title: "Novo Carro", value: 2000.00, weeks: 45, motivaton: "", priority: 2, methodologyGoal: MethodologyGoal(weeks: 52, crescent: true))
        )
    }
}

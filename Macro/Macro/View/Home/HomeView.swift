//
//  HomeUIView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct HomeView: View {
    
    var viewsCells = [
        GoalCardView(viewModel: GoalCardViewModel(), id: 1, goal: Goal(title: "Carro Novo", value: 20000, weeks: 48, motivation: "Realização de um sonho", priority: 1, methodologyGoal: MethodologyGoal(weeks: 52, crescent: true))),
        GoalCardView(viewModel: GoalCardViewModel(), id: 2, goal: Goal(title: "Comprar Ape", value: 159000, weeks: 20, motivation: "Morar juntos", priority: 1, methodologyGoal: MethodologyGoal(weeks: 52, crescent: true))),
        GoalCardView(viewModel: GoalCardViewModel(), id: 3, goal: Goal(title: "Jantar Terraço", value: 1000, weeks: 48, motivation: "Realização de um sonho", priority: 1, methodologyGoal: MethodologyGoal(weeks: 52, crescent: true)))
    ]
    
    var viewCardSpends = [
        SpentsCardView(id: 1),
        SpentsCardView(id: 2),
        SpentsCardView(id: 3)
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Nossas metas")
                        .font(.title2)
                        .bold()
                        .padding([.bottom, .leading, .trailing])
                    Spacer()
                    Button(role: nil) {
                        print("add meta")
                    } label: {
                        Label("", systemImage: "plus")
                            .tint(.blue)
                            .padding(.bottom, 15.0)
                            .padding(.trailing)
                    }

                }
                .padding(.top)
                CarouselView( width: UIScreen.screenWidth*53/64, heigth: UIScreen.screenHeight/5, viewsCells: viewsCells)
                HStack {
                    Text("Nossas Gastos")
                        .font(.title2)
                        .bold()
                        .padding([.top, .leading])
                    Spacer()
                }
                VStack {
                    ForEach(viewCardSpends) { spends in
                        NavigationLink(destination: SpentView()) {
                            spends
                                .padding()
                        }
                    }
                }

            }
            .navigationTitle("Bom dia!")
            .toolbar {
                Button(role: nil) {
                    print("add configuração")
                } label: {
                    Label("", systemImage: "gearshape")
                        .tint(.blue)
                        .padding(.trailing)
                        .padding(.top)
                }
                
            }
        }
    }
    
}

struct HomeUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

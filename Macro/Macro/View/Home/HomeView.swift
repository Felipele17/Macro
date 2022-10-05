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
        SpentsCardView(spentsCards: SpentsCards(id: 1, colorName: "PriorityColor", title: "Prioridades")),
        SpentsCardView(spentsCards: SpentsCards(id: 2, colorName: "PriorityColor", title: "Prioridades")),
        SpentsCardView(spentsCards: SpentsCards(id: 3, colorName: "PriorityColor", title: "Prioridades"))
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Nossas metas")
                        .font(.custom(EnumFonts.semibold.rawValue, size: 28))
                        .padding()
                    Spacer()
                    Button(role: nil) {
                        print("add meta")
                    } label: {
                        Label("", systemImage: "plus")
                            .foregroundColor(Color(EnumColors.ButtonColor.rawValue))
                            .padding(.bottom, 15.0)
                            .padding(.trailing)
                    }
                } .padding(.top, 48)
                CarouselView( width: UIScreen.screenWidth*53/64, heigth: UIScreen.screenHeight/5, viewsCells: viewsCells)
                HStack {
                    Text("Nossos Gastos")
                        .font(.custom(EnumFonts.semibold.rawValue, size: 28))
                        .padding([.top, .leading])
                    Spacer()
                }
                VStack {
                    ForEach(SpentsCards.spentsCards) { spends in
                        NavigationLink(destination: SpentView()) {
                            SpentsCardView(spentsCards: spends)
                                .padding()
                            
                        }
                    }
                }

            }
            .navigationTitle("Bom dia!")
            .font(.custom(EnumFonts.bold.rawValue, size: 34))
            .toolbar {
                Button(role: nil) {
                    print("add configuração")
                } label: {
                    Label("", systemImage: "gearshape")
                        .foregroundColor(Color(EnumColors.ButtonColor.rawValue))
                        .padding(.trailing)
                        .padding(.top)
                }
                
            }
        }.navigationBarHidden(true)
    }
    
}

struct HomeUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

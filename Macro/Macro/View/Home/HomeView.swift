//
//  HomeUIView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @State var isActive: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Nossas metas")
                        .font(.custom(EnumFonts.semibold.rawValue, size: 28))
                        .padding()
                    Spacer()
                    if let  methodologyGoals = viewModel.methodologyGoals {
                        NavigationLink(destination:
                                        FormsGoalsNameView(
                                            goal: Goal(title: "", value: 0.0, weeks: 0, motivation: "", priority: 0, methodologyGoal: methodologyGoals)
                                        ,popToRoot: $isActive), isActive: $isActive
                        ) {
                            Label("", systemImage: "plus")
                                .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                                .font(.custom(EnumFonts.semibold.rawValue, size: 28))
                                .padding()
                        }
                    }
                }
                .padding(.top)
                CarouselView( width: UIScreen.screenWidth*53/64, heigth: UIScreen.screenHeight/5, goals: $viewModel.goals)
                
                VStack(spacing: 0) {
                    HStack {
                        Text("Nossos Gastos")
                            .font(.custom(EnumFonts.semibold.rawValue, size: 28))
                            .padding([.top, .leading])
                        
                        Spacer()
                    }
                    ForEach(viewModel.spentsCards) { spentCard in
                        NavigationLink(destination: SpentView(
                            spentsCard: spentCard,
                            spents: viewModel.dictionarySpent[spentCard.valuesPercent] ?? [])) {
                            SpentsCardView(spentsCard: spentCard)
                                .padding()
                        }
                    }
                }
                
            }
            .background(Color(EnumColors.backgroundScreen.rawValue))
            .navigationTitle("Bom dia!")
            .navigationBarTitleDisplayMode(.large)
            .font(.custom(EnumFonts.bold.rawValue, size: 34))
            .toolbar {
                //                Button(role: nil) {
                //                    print("add configuração")
                //                } label: {
                //                    Label("", systemImage: "gearshape")
                //                        .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                //                        .padding(.trailing)
                //                        .padding(.top)
                //                }
                
            }
        }.accentColor(Color(EnumColors.buttonColor.rawValue))
        .navigationBarBackButtonHidden(true)
    }
}

struct HomeUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

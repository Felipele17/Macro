//
//  HomeUIView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct HomeView: View {
    @State var isActive: Bool = false
    @EnvironmentObject var spentViewModel: SpentViewModel
    @EnvironmentObject var goalViewModel: GoalViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Nossas metas")
                        .font(.custom(EnumFonts.semibold.rawValue, size: 28))
                         .padding()
                    Spacer()
                    if let goal = Goal.mockGoals(methodologyGoals: goalViewModel.methodologyGoals) {
                        NavigationLink(destination: FormsGoalsNameView(goal: goal, goals: $goalViewModel.goals, popToRoot: $isActive)
                            .environmentObject(goalViewModel)
                        ,isActive: $isActive ) {
                            Label("", systemImage: "plus")
                                .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                                .font(.custom(EnumFonts.semibold.rawValue, size: 28))
                                .padding()
                        }
                    }
                }
                .padding(.top)
                CarouselView( width: UIScreen.screenWidth*53/64, heigth: UIScreen.screenHeight/5)
                    .environmentObject(goalViewModel)
                
                VStack(spacing: 0) {
                    HStack {
                        Text("Nossos Gastos")
                            .font(.custom(EnumFonts.semibold.rawValue, size: 28))
                            .padding([.top, .leading])
                        
                        Spacer()
                    }
                    ForEach(spentViewModel.spentsCards) { spentsCard in
                        NavigationLink(destination:
                                SpentView(spentsCard: spentsCard)
                                    .environmentObject(spentViewModel)
                        ) {
                            SpentsCardView(spentsCard: spentsCard)
                                .padding()
                        }
                    }
                }
                
            }
            .background(Color(EnumColors.backgroundScreen.rawValue))
            .navigationTitle("Bom dia \(UserDefaults.standard.string(forKey: "username") ?? "")!")
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

// struct HomeUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
// }

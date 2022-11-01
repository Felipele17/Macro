//
//  HomeUIView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct HomeView: View {
    @State var isActive: Bool = false
    @Binding var users: [User]
    @Binding var dictionarySpent: [[Spent]]
    @Binding var goals: [Goal]
    @Binding var spentsCards: [SpentsCard]
    var methodologyGoals: MethodologyGoal
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Nossas metas")
                        .font(.custom(EnumFonts.semibold.rawValue, size: 28))
                         .padding()
                    Spacer()
                    if let goal = Goal.mockGoals(methodologyGoals: methodologyGoals) {
                        NavigationLink(destination: FormsGoalsNameView(goal: goal, goals: $goals, popToRoot: $isActive)
                        ,isActive: $isActive ) {
                            Label("", systemImage: "plus")
                                .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                                .font(.custom(EnumFonts.semibold.rawValue, size: 28))
                                .padding()
                        }
                    }
                }
                .padding(.top)
                CarouselView( width: UIScreen.screenWidth*53/64, heigth: UIScreen.screenHeight/5, goals: $goals)
                
                VStack(spacing: 0) {
                    HStack {
                        Text("Nossos Gastos")
                            .font(.custom(EnumFonts.semibold.rawValue, size: 28))
                            .padding([.top, .leading])
                        
                        Spacer()
                    }
                    ForEach($spentsCards) { spentsCard in
                        NavigationLink(destination:
                                        SpentView(viewModel: SpentViewModel(spentsCard: spentsCard, arraySpents: $dictionarySpent[spentsCard.id]))
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

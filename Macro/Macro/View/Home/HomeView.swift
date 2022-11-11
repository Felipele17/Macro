//
//  HomeUIView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct HomeView: View {
    @State var showingSheet: Bool = false
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @EnvironmentObject var spentViewModel: SpentViewModel
    @EnvironmentObject var goalViewModel: GoalViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    Text("Bom dia, \(UserDefault.getUsername())!")
                    .font(.custom(EnumFonts.bold.rawValue, size: 34))
                    .padding(.top)
                    Spacer()
                    NavigationLink(destination:
                                    SettingsView()
                    ) {
                        Label("", systemImage: "list.bullet")
                            .font(.custom(EnumFonts.bold.rawValue, size: 22))
                            .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                            
                    }.padding(.top)
                }.padding()
                HStack {
                    Text("Nossas metas")
                        .font(.custom(EnumFonts.semibold.rawValue, size: 28))
                        .padding()
                    Spacer()
                    if let goal = Goal.mockGoals(methodologyGoals: goalViewModel.methodologyGoals) {
                        Button {
                            showingSheet.toggle()
                        } label: {
                            Label("", systemImage: "plus")
                                .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                                .font(.custom(EnumFonts.semibold.rawValue, size: 28))
                                .padding()
                        }
                        .sheet(isPresented: $showingSheet) {
                            FormsGoalsNameView(goal: goal, popToRoot: $showingSheet)
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
            .navigationBarTitleDisplayMode(.large)
            .font(.custom(EnumFonts.bold.rawValue, size: 34))
        }.accentColor(Color(EnumColors.buttonColor.rawValue))
            .navigationBarBackButtonHidden(true)
    }
}

// struct HomeUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
// }

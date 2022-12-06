//
//  HomeUIView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct HomeView: View {
    @State var showingSheet: Bool = false
    @EnvironmentObject var pathController: PathController
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @EnvironmentObject var spentViewModel: SpentViewModel
    @EnvironmentObject var goalViewModel: GoalViewModel
    @EnvironmentObject var observableDataBase: ObservableDataBase
    var body: some View {
        NavigationStack(path: $pathController.path) {
            ScrollView {
                HStack {
                    Text("Olá, \(settingsViewModel.users.first?.name ?? "...")!")
                    .font(.custom(EnumFonts.bold.rawValue, size: 34))
                    .padding(.top)
                    Spacer()
                    NavigationLink(value: EnumViewNames.settingsView ) {
                        Label("", systemImage: "gearshape.2.fill")
                            .font(.custom(EnumFonts.bold.rawValue, size: 22))
                            .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                            
                    }
                    .padding(.top)
                }
                .padding()

                HStack {
                    Text("Nossas metas")
                        .font(.custom(EnumFonts.semibold.rawValue, size: 28))
                        .padding()
                    Spacer()
                    NavigationLink(value: EnumViewNames.formsGoalsNameView) {
                        Label("", systemImage: "plus")
                            .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                            .font(.custom(EnumFonts.semibold.rawValue, size: 28))
                            .padding()

                    }
                }
                //.padding(.top)
                CarouselView( width: UIScreen.screenWidth*53/64, heigth: UIScreen.screenHeight/5)
                    .environmentObject(goalViewModel)
                    .onAppear {
                        goalViewModel.moveCompletedGoalToEnd()
                    }
                
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
            .navigationDestination(for: EnumViewNames.self ) { destination in
                pathController.pushPath(destination: destination)
            }
            .refreshable {
                observableDataBase.needFetchSpent = true
                observableDataBase.needFetchGoal = true
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

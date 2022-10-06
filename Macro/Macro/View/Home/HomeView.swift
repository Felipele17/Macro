//
//  HomeUIView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
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
                            .foregroundColor(Color(EnumColors.buttonColor.rawValue))
                            .padding(.bottom, 15.0)
                            .padding(.trailing)
                    }
                }
                .padding(.top, 48)
                CarouselView( width: UIScreen.screenWidth*53/64, heigth: UIScreen.screenHeight/5, goals: $viewModel.goals)
                HStack {
                    Text("Nossos Gastos")
                        .font(.custom(EnumFonts.semibold.rawValue, size: 28))
                        .padding([.top, .leading])
                    Spacer()
                }
                VStack {
                    ForEach ($viewModel.spentsCards) { spentsCard in
                        NavigationLink {
                            SpentView()
                        } label: {
                            SpentsCardView(spentsCard: spentsCard)
                        }
                    }
                }
                Spacer()
            }
            .navigationTitle("Bom dia\(viewModel.getUserName())")
            .font(.custom(EnumFonts.bold.rawValue, size: 34))
            .toolbar {
                Button(role: nil) {
                    print(viewModel.users.first?.income)
                } label: {
                    Label("", systemImage: "gearshape")
                        .foregroundColor(Color(EnumColors.buttonColor.rawValue))
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

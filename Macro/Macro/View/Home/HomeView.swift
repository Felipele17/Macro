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
                            .font(.custom(EnumFonts.semibold.rawValue, size: 28))
                            .padding()
                    }
                }
                .padding(.top, 48)
                CarouselView( width: UIScreen.screenWidth*53/64, heigth: UIScreen.screenHeight/5, goals: $viewModel.goals)
                
                VStack(spacing: 0) {
                    HStack {
                        Text("Nossos Gastos")
                            .font(.custom(EnumFonts.semibold.rawValue, size: 28))
                            .padding([.top, .leading])
                        
                        Spacer()
                    }
                    // $viewModel.spentsCards
                    ForEach( $viewModel.spentsCards) { spent in
                        NavigationLink(destination: SpentView(title: spent.namePercent)) {
                            SpentsCardView(spentsCard: spent)
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
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct HomeUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

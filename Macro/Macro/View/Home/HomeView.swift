//
//  HomeUIView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct HomeView: View {
    
    var viewsCells = [
        GoalCardView(id: 1),
        GoalCardView(id: 2),
        GoalCardView(id: 3)
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
                CarouselView(viewModel: CarouselViewModel( width: UIScreen.screenWidth*53/64, heigth: UIScreen.screenHeight/5), viewsCells: viewsCells)
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

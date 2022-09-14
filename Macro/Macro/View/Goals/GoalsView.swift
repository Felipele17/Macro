//
//  ContentView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct GoalsView: View {
    
    @State private var selectFilter = 0
    
    var body: some View {
        VStack {
            GraphView()
                .cornerRadius(cornerRadiusNumber())
                .shadow(radius: cornerRadiusNumber())
                .frame(height: UIScreen.screenHeight/4)
                .padding()
            ZStack {
                Color.white
                    .cornerRadius(cornerRadiusNumber())
                    .shadow(radius: cornerRadiusNumber())
                VStack {
                    Text("Faltam R$19500,00")
                        .font(.title3)
                        .bold()
                    Text("de R$20000,00")
                }
            }
            .frame(height: UIScreen.screenHeight/8)
            .padding([.leading, .trailing, .bottom])
            VStack {
                Picker("Qual filtro voce?", selection: $selectFilter) {
                    Text("Todos").tag(0)
                    Text("Á fazer").tag(1)
                    Text("Concluído").tag(2)
                }
                .pickerStyle(.segmented)
                .padding([.leading, .trailing])
                List {
                    WeakGoalsView()
                        .listRowBackground(Color.indigo)
                        .colorInvert()
                    WeakGoalsView()
                    WeakGoalsView()
                    WeakGoalsView()
                }
            }
        }
        .navigationTitle("Carro Novo")
        .toolbar {
            Button(role: nil) {
                print("add configuração")
            } label: {
                Text("editar")
                    .tint(.blue)
            }
        }
    }
}

extension GoalsView {
    private func cornerRadiusNumber() -> CGFloat {
        return 10
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GoalsView()
    }
}

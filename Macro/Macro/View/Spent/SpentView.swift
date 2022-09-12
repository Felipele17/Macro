//
//  SpentView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import SwiftUI

struct SpentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Gasto atual")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading, .top])
                Text("R$ 1470,00")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                Text("Limite disponivel R$ 530,00")
                    .font(.system(size: 20, weight: .light, design: .default))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                HStack {
                    Text("Gasto Essenciais")
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    Spacer()
                    Button {
                        print("add gasto")
                    } label: {
                        Label("", systemImage: "plus")
                            .padding(.trailing)
                    }

                }
                List {
                    SpentsDetailsCardView()
                    SpentsDetailsCardView()
                    SpentsDetailsCardView()
                    SpentsDetailsCardView()
                }
            }
            .navigationTitle("Essencial")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

struct SpentView_Previews: PreviewProvider {
    static var previews: some View {
        SpentView()
    }
}

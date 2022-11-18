//
//  CompletedGoalView.swift
//  Macro
//
//  Created by Vitor Cheung on 17/11/22.
//

import SwiftUI

struct CompletedGoalView: View {
    @EnvironmentObject var goalViewModel: GoalViewModel
    @Environment(\.presentationMode) var presentationMode: Binding <PresentationMode>
    @State var showingAlert = false
    var goal: Goal
    var body: some View {
        VStack {
            Image("medal")
                .resizable()
                .scaledToFit()
                .frame(width: 129)
                .padding(.bottom)
            Text("Parabéns, vocês conquistaram o \(goal.title) no valor de \(goal.value.currency)!")
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Continue")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color(EnumColors.buttonColor.rawValue))
                    .cornerRadius(13)
            }
            .padding()

        }
        .toolbar {
            Button("deletar") {
                showingAlert.toggle()
            }
            .alert("Deseja deletar meta?", isPresented: $showingAlert) {
                Button(role: .cancel) {
                }
            label: {
                Text("Não")
            }
                Button("Sim") {
                    goalViewModel.deleteGoal(goal: goal)
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}


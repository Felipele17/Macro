//
//  SpentCardViewModel.swift
//  Macro
//
//  Created by Gabriele Namie on 28/09/22.
//

import Foundation

class SpentCarViewModel: ObservableObject {
    private let cloud = CloudKitModel.shared
    func deleteSpent(spent: Spent) {
        Task.init {
            await cloud.delete(model: spent)
        }
    }
}

//
//  ObservableDataBase.swift
//  Macro
//
//  Created by Vitor Cheung on 27/10/22.
//

import Foundation
class ObservableDataBase: ObservableObject {
    static var shared = ObservableDataBase()
    @Published var needFetchGoal: Bool = false
    @Published var needFetchSpent: Bool = false
    private init() {}
}

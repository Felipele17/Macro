//
//  Perfil.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import Foundation

class User{
    var name : String
    var income : Int
    var MethodologySpent : MethodologySpent
    
    init(name:String, income:Int, MethodologySpent:MethodologySpent){
        self.name = name
        self.income = income
        self.MethodologySpent = MethodologySpent
    }
}

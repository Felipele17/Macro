//
//  Gasto.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import Foundation

class Spent{
    var titulo : String
    var valor : Int
    var categoria : CategoriaSpent
    
    init(titulo:String, valor:Int, categoria:CategoriaSpent){
        self.titulo = titulo
        self.valor = valor
        self.categoria = categoria
    }
}

//
//  Meta.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import Foundation

class Meta{
    var titulo : String
    var valor : Int
    var categoria : CategoriaMeta
    
    init(titulo:String, valor:Int, categoria:CategoriaMeta){
        self.titulo = titulo
        self.valor = valor
        self.categoria = categoria
    }
}

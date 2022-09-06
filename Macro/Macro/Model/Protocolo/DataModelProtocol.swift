//
//  dataProtocol.swift
//  Macro
//
//  Created by Vitor Cheung on 06/09/22.
//

import Foundation
protocol DataModelProtocol{
    func getType() -> String
    func getID() -> UUID
    func getProperties() -> [String]
    func getData() -> [String: Any]
}

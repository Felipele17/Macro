//
//  dataProtocol.swift
//  Macro
//
//  Created by Vitor Cheung on 06/09/22.
//

import Foundation
import CloudKit
protocol DataModelProtocol {
    static func getType() -> String
    func getID() -> UUID
    func getProperties() -> [String]
    func getData() -> [String: Any?]
    init?(record: CKRecord) async
}

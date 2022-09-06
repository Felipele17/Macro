//
//  SharedZone.swift
//  Macro
//
//  Created by Vitor Cheung on 06/09/22.
//
import CloudKit
import Foundation
enum SharedZone {
    static let name = "SharedZone"
    static let ZoneID = CKRecordZone.ID(
        zoneName: name,
        ownerName: CKCurrentUserDefaultName
    )
}

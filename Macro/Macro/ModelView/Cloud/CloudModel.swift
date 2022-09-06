//
//  CloudModelView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import Foundation
import CloudKit
import OSLog

class CloudKitModel {
    let container: CKContainer
    let databasePrivate: CKDatabase
    let databaseShared: CKDatabase
    
    static var shared = CloudKitModel()
    
    init() {
        container = CKContainer(identifier: "iCloud.vitorCheung.Macro")
        databasePrivate = container.privateCloudDatabase
        databaseShared = container.sharedCloudDatabase
    }
    
}

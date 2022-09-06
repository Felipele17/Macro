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
    
    //MARK: Post
    func post(recordType: String, model: DataModelProtocol) async throws {

        let recordId = CKRecord.ID(recordName: model.getID().description, zoneID:  SharedZone.ZoneID)
        let record = CKRecord(recordType: recordType, recordID: recordId)
        let properties = model.getProperties()
        let propertiesdata = model.getData()
        for  propertie in properties {
            if let dataInt = propertiesdata[propertie] as? Int {
                record[propertie] =  dataInt as CKRecordValue
            }else if let dataString = propertiesdata[propertie] as? String{
                record[propertie] =  dataString as CKRecordValue
            }
        }
        do {
            try await container.privateCloudDatabase.save(record)
        } catch {
            print(error.localizedDescription)
        }
    }
}

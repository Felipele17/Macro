//
//  CloudModelView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import Foundation
import CloudKit
import SwiftUI

class CloudKitModel {
    let container: CKContainer
    let databasePrivate: CKDatabase
    let databaseShared: CKDatabase
    var share: CKShare?
    
    static var shared = CloudKitModel()
    
    init() {
        container = CKContainer(identifier: "iCloud.vitorCheung.Macro")
        databasePrivate = container.privateCloudDatabase
        databaseShared = container.sharedCloudDatabase
        Task.init {
            do {
                share = try await getShare()
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
    
    // MARK: Post
    func post(recordType: String, model: DataModelProtocol) async throws {

        let recordId = CKRecord.ID(recordName: model.getID().description, zoneID: SharedZone.ZoneID)
        let record = CKRecord(recordType: recordType, recordID: recordId)
        let properties = model.getProperties()
        let propertiesdata = model.getData()
        for  propertie in properties {
            if let dataInt = propertiesdata[propertie] as? Int {
                record[propertie] =  dataInt as CKRecordValue
            } else if let dataString = propertiesdata[propertie] as? String {
                record[propertie] =  dataString as CKRecordValue
            }
        }
        do {
            try await container.privateCloudDatabase.save(record)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: Share
    private func createShare() async throws -> CKShare? {
        _ = try await databasePrivate.modifyRecordZones(
            saving: [CKRecordZone(zoneName: SharedZone.name)],
            deleting: []
        )
        share = CKShare(recordZoneID: SharedZone.ZoneID)
        share?.publicPermission = .readWrite
        guard let share = share else { return nil}
        _ = try? await databasePrivate.save(share)
        return self.share
    }
    
    func getShare() async throws -> CKShare? {
                    
        let recordID = CKRecord.ID(recordName: CKRecordNameZoneWideShare, zoneID: SharedZone.ZoneID)
        guard let share = try await databasePrivate.record(for: recordID) as? CKShare else {
            guard let share = try? await createShare() else { return nil }
            return share
        }
        return share
            
    }
    
    func makeUIViewController() -> UICloudSharingController? {
        
        guard let share = share else { return nil }
        
        let sharingController = UICloudSharingController(
            share: share,
            container: container
        )
        sharingController.availablePermissions = [.allowReadOnly, .allowPrivate]
        sharingController.modalPresentationStyle = .formSheet
        return sharingController
    }
    
    // MARK: fecth
    func fetchSharedPrivatedRecords(recordType: String, predicate: String) async throws -> [CKRecord] {
        let sharedZones = try await container.sharedCloudDatabase.allRecordZones()
        
        return try await withThrowingTaskGroup(of: [CKRecord].self, returning: [CKRecord].self) { group in
            for zone in sharedZones {
                group.addTask { [self] in
                    do {
                        let fecthShared = try await self.fetchRecords( in: zone.zoneID, from: self.databaseShared, recordType: recordType, predicate: predicate)
                        let fecthPrivate = try await self.fetchRecords( in: zone.zoneID, from: self.databasePrivate, recordType: recordType, predicate: predicate)
                        return fecthShared + fecthPrivate
                    } catch {
                        print(error.localizedDescription)
                        return []
                    }
                }
            }
            
            var results: [CKRecord] = []
            for try await history in group { results.append(contentsOf: history) }
            return results
        }
    }
    
    private func fetchRecords(in zone: CKRecordZone.ID? = SharedZone.ZoneID, from database: CKDatabase, recordType: String, predicate: String ) async throws -> [CKRecord] {
        let predicate = NSPredicate(format: predicate)
        let query = CKQuery(recordType: recordType, predicate: predicate)
        let response = try await database.records(
            matching: query,
            inZoneWith: zone,
            desiredKeys: nil,
            resultsLimit: CKQueryOperation.maximumResults
        )
        
        return response.matchResults.compactMap { results in
            try? results.1.get()
        }
    }
    
    func fetchByID(id: String, tipe: String) async throws -> CKRecord? {
        do {
            let record = try await self.fetchSharedPrivatedRecords(recordType: tipe, predicate: "idName = \(id)")
            guard let record = record.first else { return nil }
            return record
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
}

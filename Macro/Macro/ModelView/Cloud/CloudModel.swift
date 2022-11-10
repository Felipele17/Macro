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
    private var share: CKShare?
    
    static var shared = CloudKitModel()
    
    private init() {
        container = CKContainer(identifier: "iCloud.vitorCheung.Macro")
        databasePrivate = container.privateCloudDatabase
        databaseShared = container.sharedCloudDatabase
        Task.init {
            share = await loadShare()
            await saveNotification(recordType: "cloudkit.share", database: .dataPrivate)
        }
    }
    
    // MARK: PushNotification
    func saveNotification(recordType: String, database: EnumDatabase) async {
        
        // Only proceed if the subscription doesn't already exist.
        guard !UserDefaults.standard.bool(forKey: "didCreateSubscription\(recordType)")
            else { return }
                
        // Create a subscription with an ID that's unique within the scope of
        // the user's private database.
        let subscription = CKDatabaseSubscription(subscriptionID: "\(recordType)-changes")

        // Scope the subscription to just the 'FeedItem' record type.
        subscription.recordType = "\(recordType)"
                
        // Configure the notification so that the system delivers it silently
        // and, therefore, doesn't require permission from the user.
        let notificationInfo = CKSubscription.NotificationInfo()
        notificationInfo.shouldSendContentAvailable = true
        subscription.notificationInfo = notificationInfo
    
        // Create an operation that saves the subscription to the server.
        let operation = CKModifySubscriptionsOperation(
            subscriptionsToSave: [subscription], subscriptionIDsToDelete: nil)
        
        operation.modifySubscriptionsResultBlock = { result in
            switch result {
            case .success:
                UserDefaults.standard.setValue(true, forKey: "didCreateSubscription\(recordType)")
            case .failure(let error):
                print("Cloud - saveNotification")
                print(error.localizedDescription)
            }
        }
        
        // Set an appropriate QoS and add the operation to the private
        // database's operation queue to execute it.
        operation.qualityOfService = .utility
        switch database {
        case .dataPrivate:
            databasePrivate.add(operation)
        case .dataShare:
            databaseShared.add(operation)
        }

    }
    
    // MARK: Post
    func post(model: DataModelProtocol) async throws {

        let recordId = CKRecord.ID(recordName: model.getID().description, zoneID: SharedZone.ZoneID)
        let record = populateRecord(record: CKRecord(recordType: model.getType(), recordID: recordId), model: model)
        
        do {
            try await container.privateCloudDatabase.save(record)
        } catch {
            print("Cloud - post")
            print(error.localizedDescription)
        }
    }
    
    private func populateRecord(record: CKRecord, model: DataModelProtocol) -> CKRecord {
        let properties = model.getProperties()
        let propertiesdata = model.getData()
        for  propertie in properties {
            if let dataInt = propertiesdata[propertie] as? Int {
                record[propertie] =  dataInt as CKRecordValue
            } else if let dataIntList = propertiesdata[propertie] as? [Int] {
                record[propertie] =  dataIntList as CKRecordValue
            } else if let dataString = propertiesdata[propertie] as? String {
                record[propertie] =  dataString as CKRecordValue
            } else if let dataStringList = propertiesdata[propertie] as? [String] {
                record[propertie] =  dataStringList as CKRecordValue
            } else if let dataFloat = propertiesdata[propertie] as? Float {
                record[propertie] =  dataFloat as CKRecordValue
            } else if let dataBool = propertiesdata[propertie] as? Bool {
                record[propertie] =  dataBool as CKRecordValue
            } else if let dataDate = propertiesdata[propertie] as? Date {
                record[propertie] =  dataDate as CKRecordValue
            }
            
        }
        return record
    }
    
    // MARK: Update
    func update(model: DataModelProtocol) async {
        var record: CKRecord?
        do {
            record = try await fetchByID(id: model.getID().description, tipe: model.getType())
        } catch {
            print("Cloud - update fetchByID")
            print(error.localizedDescription)
        }
        
        guard let record = record else { return }
        let recordPopulated = populateRecord(record: record, model: model)
        
        do {
            try await container.privateCloudDatabase.save(recordPopulated)
        } catch {
            print("Cloud - update private")
            print(error.localizedDescription)
            do {
                try await container.sharedCloudDatabase.save(recordPopulated)
            } catch {
                print("Cloud - update Shared")
                print(error.localizedDescription)
            }
        }
    }
    
    private func updateShared(model: DataModelProtocol) async throws -> [CKRecord] {
        do {
            let sharedZones = try await container.sharedCloudDatabase.allRecordZones()
            return try await withThrowingTaskGroup(of: [CKRecord].self, returning: [CKRecord].self) { group in
                for zone in sharedZones {
                    group.addTask { [self] in
                        let recordId = CKRecord.ID(recordName: model.getID().uuidString, zoneID: zone.zoneID)
                        do {
                            let fecthRecord = try await databasePrivate.record(for: recordId)
                            return [fecthRecord]
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
        } catch {
            print("Cloud - updateShared")
            print(error.localizedDescription)
            return []
        }
    }
    
    func delete(model: DataModelProtocol) async {
        var record: CKRecord?
        do {
            record = try await fetchByID(id: model.getID().description, tipe: model.getType())
        } catch {
            print("Cloud - delete(fetchByID)")
            print(error.localizedDescription)
        }
        
        guard let record = record else { return }
        let recordPopulated = populateRecord(record: record, model: model)
        
        do {
            try await container.privateCloudDatabase.deleteRecord(withID: recordPopulated.recordID)
        } catch {
            do {
                try await container.sharedCloudDatabase.deleteRecord(withID: recordPopulated.recordID)
            } catch {
                print("Cloud - delete")
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: Share
    private func createShare() async throws -> CKShare? {
        _ = try await databasePrivate.modifyRecordZones(
            saving: [CKRecordZone(zoneName: SharedZone.name)],
            deleting: []
        )
        let share = CKShare(recordZoneID: SharedZone.ZoneID)
        share.publicPermission = .readWrite
        do {
            try await databasePrivate.save(share)
            return share
        } catch {
            return nil
        }
    }
    
    func deleteShare() async {
            let predicate = NSPredicate(value: true)
            do {
                let ckShares = try await fetchSharedPrivatedRecords(recordType: "cloudkit.share", predicate: predicate)
                for share in ckShares {
                    do {
                        try await databasePrivate.deleteRecord(withID: share.recordID)
                    } catch {
                        try await databaseShared.deleteRecord(withID: share.recordID)
                    }
                    
                }
            } catch let erro {
                print("deleteShare")
                print(erro.localizedDescription)
            }
    }
    
    func fetchShare(database: EnumDatabase) async throws -> CKShare? {
        let recordID = CKRecord.ID(recordName: CKRecordNameZoneWideShare, zoneID: SharedZone.ZoneID)
        do {
            return try await databasePrivate.record(for: recordID) as? CKShare
        } catch let erro {
            print("Cloud - fetchShare")
            print(erro.localizedDescription)
            return nil
        }
    }
    
    private func getShare() async throws -> CKShare? {
        guard let share = try await createShare() else {
            do {
                return try await fetchShare(database: .dataPrivate)
            } catch let error {
                print("Cloud - getShare")
                print(error.localizedDescription)
                return nil
            }
        }
        return share
    }
    
    func loadShare() async -> CKShare? {
        do {
            if share == nil {
                share = try await getShare()
            }
        } catch let error {
            print("Cloud - loadShare")
            print(error.localizedDescription)
        }
        return share
    }
    
    func makeUIViewControllerShare() -> UICloudSharingController? {

        guard let share = share else { return nil }

        let sharingController = UICloudSharingController(
            share: share,
            container: container
        )
        sharingController.availablePermissions = .allowPublic
        sharingController.modalPresentationStyle = .formSheet
        return sharingController
    }
    
    func getSharedZone() async throws -> CKRecordZone.ID? {
        let records = try? await databaseShared.allRecordZones()
        return records?.first?.zoneID
    }
    
    func accept(_ metadata: CKShare.Metadata) async {
        do {
            try await container.accept(metadata)
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    // MARK: fetch
    func fetchSharedPrivatedRecords(recordType: String, predicate: NSPredicate) async throws -> [CKRecord] {
        let sharedZones = try await container.sharedCloudDatabase.allRecordZones()
        
        let fecthPrivate = try await self.fetchRecords( in: SharedZone.ZoneID, from: self.databasePrivate, recordType: recordType, predicate: predicate)
        
        let fecthShared = try await withThrowingTaskGroup(of: [CKRecord].self, returning: [CKRecord].self) { group in
            for zone in sharedZones {
                group.addTask { [self] in
                    do {
                        let fecthShared = try await self.fetchRecords( in: zone.zoneID, from: self.databaseShared, recordType: recordType, predicate: predicate)
                        return fecthShared
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
        return fecthPrivate + fecthShared
    }
    
    private func fetchRecords(in zone: CKRecordZone.ID? = SharedZone.ZoneID, from database: CKDatabase, recordType: String, predicate: NSPredicate ) async throws -> [CKRecord] {
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
            let predicate = NSPredicate(format: "recordID == %@", CKRecord.ID(recordName: id))
            let record = try await self.fetchSharedPrivatedRecords(recordType: tipe, predicate: predicate)
            guard let record = record.first else { return nil }
            return record
        } catch let error {
            print("Cloud - fetchByID")
            print(error.localizedDescription)
        }
        return nil
    }
}

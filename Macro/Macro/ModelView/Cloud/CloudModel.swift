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
    
    private init() {
        container = CKContainer(identifier: "iCloud.vitorCheung.Macro")
        databasePrivate = container.privateCloudDatabase
        databaseShared = container.sharedCloudDatabase
        Task.init {
            await loadShare()
            await saveNotification(recordType: "cloudkit.share")
        }
    }
    
    // MARK: PushNotification
    func saveNotification(recordType: String) async {
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
                print(error.localizedDescription)
            }
        }
        
        // Set an appropriate QoS and add the operation to the private
        // database's operation queue to execute it.
        operation.qualityOfService = .utility
        databasePrivate.add(operation)
    }
    
    // MARK: Post
    func post(recordType: String, model: DataModelProtocol) async throws {

        let recordId = CKRecord.ID(recordName: model.getID().description, zoneID: SharedZone.ZoneID)
        let record = populateRecord(record: CKRecord(recordType: recordType, recordID: recordId), model: model)
        
        do {
            try await container.privateCloudDatabase.save(record)
        } catch {
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
    func update(model: DataModelProtocol) async throws {
        let recordId = CKRecord.ID(recordName: model.getID().uuidString, zoneID: SharedZone.ZoneID)
        let fecthRecord = try? await databasePrivate.record(for: recordId)
        guard let record = fecthRecord else { return  }
        let recordPopulated = populateRecord(record: record, model: model)
        
        do {
            try await container.privateCloudDatabase.save(recordPopulated)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func delete(model: DataModelProtocol) async {
        let recordId = CKRecord.ID(recordName: model.getID().uuidString, zoneID: SharedZone.ZoneID)
        do {
            try await container.privateCloudDatabase.deleteRecord(withID: recordId)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: Share
    private func createShare() async throws -> CKShare? {

        let share = CKShare(recordZoneID: SharedZone.ZoneID)
        share.publicPermission = .readWrite
        do {
            try await databasePrivate.save(share)
            return share
        } catch {
            return nil
        }
        
    }
    
    func fetchShare() async throws -> CKShare? {
        let recordID = CKRecord.ID(recordName: CKRecordNameZoneWideShare, zoneID: SharedZone.ZoneID)
        do {
            let share = try await databasePrivate.record(for: recordID) as? CKShare
            return share
        } catch let erro {
            print(erro.localizedDescription)
            return nil
        }
    }
    
    func getShare() async throws -> CKShare? {
        _ = try await databasePrivate.modifyRecordZones(
            saving: [CKRecordZone(zoneName: SharedZone.name)],
            deleting: []
        )
        guard let share = try await createShare() else {
            return try? await fetchShare()
        }
        return share
    }
    
    func loadShare() async {
        share = try? await getShare()
        
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
    
    func accept(_ metadata: CKShare.Metadata) async throws {
        try await container.accept(metadata)
    }
    
    // MARK: Invite
    func isReceivedInviteAccepted() async -> Bool {
        if (try? await getSharedZone()) != nil {
            return true
        } else {
            return false
        }
    }
    
    func isSendInviteAccepted() async -> Bool {
        let shared = try? await getShare()
        guard let participantes = shared?.participants.count else { return false }
        if participantes <= 1 {
            return false
        } else {
            return true
        }
    }
    
    // MARK: fecth
    func fetchSharedPrivatedRecords(recordType: String, predicate: NSPredicate) async throws -> [CKRecord] {
        let sharedZones = try await container.sharedCloudDatabase.allRecordZones()
        
        return try await withThrowingTaskGroup(of: [CKRecord].self, returning: [CKRecord].self) { group in
            for zone in sharedZones {
                group.addTask { [self] in
                    do {
                        let fecthShared = try await self.fetchRecords( in: zone.zoneID, from: self.databaseShared, recordType: recordType, predicate: predicate)
                        let fecthPrivate = try await self.fetchRecords( in: SharedZone.ZoneID, from: self.databasePrivate, recordType: recordType, predicate: predicate)
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
            print(error.localizedDescription)
        }
        return nil
    }
}

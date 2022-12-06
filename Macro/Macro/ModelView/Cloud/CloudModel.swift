//
//  CloudModelView.swift
//  Macro
//
//  Created by Vitor Cheung on 02/09/22.
//

import Foundation
import CloudKit
import SwiftUI

class CloudKitModel: ObservableObject {
    let container: CKContainer
    let databasePrivate: CKDatabase
    let databaseShared: CKDatabase
    @Published var isShareNil = true
    var share: CKShare?
    
    static var shared = CloudKitModel()
    
    private init() {
        container = CKContainer(identifier: "iCloud.vitorCheung.Macro")
        databasePrivate = container.privateCloudDatabase
        databaseShared = container.sharedCloudDatabase
        Task.init {
            share = try await getShare()
            await Invite.shared.checkSendAccepted(share: share)

        }
        Task.init {
            await saveNotification(recordType: "cloudkit.share", database: .dataPrivate)
        }
    }
    
    // MARK: PushNotification
    func saveNotification(recordType: String, database: EnumDatabase) async {
        
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
                print("saveNotification \(recordType): sucesso")
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
            isCloudFull(erroDescription: error.localizedDescription)
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
        } catch let error {
            print(error.localizedDescription)
            isCloudFull(erroDescription: error.localizedDescription)
            return nil
        }
    }
    
    func deleteShare() async {
        
        let dialogMessage = await UIAlertController(title: "Alerta", message: "Deletando dados", preferredStyle: .alert)
        let window = await UIApplication.shared.keyWindow
        await window?.rootViewController?.present(dialogMessage, animated: true)
        share = nil
        await deleteAllRecords()
        let predicate = NSPredicate(value: true)
        do {
            let ckShares = try await fetchSharedPrivatedRecords(recordType: "cloudkit.share", predicate: predicate)
            for share in ckShares {
                do {
                    try await databasePrivate.deleteRecord(withID: share.recordID)
                } catch let erro {
                    try await databaseShared.deleteRecord(withID: share.recordID)
                    print(erro.localizedDescription)
                }
                
            }
            share = try await getShare()
            await saveNotification(recordType: "cloudkit.share", database: .dataPrivate)
            DispatchQueue.main.async {
                Invite.shared.isReceivedInviteAccepted = false
                Invite.shared.isSendInviteAccepted = false
                self.isShareNil = false
                UserDefault.setFistPost(isFistPost: false)
            }
            await dialogMessage.dismiss(animated: true)
        } catch let erro {
            print("deleteShare")
            print(erro.localizedDescription)
        }
    }
    
    func fetchShare(database: EnumDatabase) async throws -> CKShare? {
        let recordID = CKRecord.ID(recordName: CKRecordNameZoneWideShare, zoneID: SharedZone.ZoneID)
        do {
            return try await databasePrivate.record(for: recordID) as? CKShare
        } catch {
            return nil
        }
    }
    
    func getShare() async throws -> CKShare? {
        guard let share =  try await fetchShare(database: .dataPrivate) else {
            do {
                let createdShare = try await createShare()
                DispatchQueue.main.async {
                    self.isShareNil = false
                }
                return createdShare
            } catch let error {
                print("Cloud - getShare")
                print(error.localizedDescription)
                return nil
            }
        }
        DispatchQueue.main.async {
            self.isShareNil = false
        }
        return share
    }
    
    func makeUIViewControllerShare() -> UICloudSharingController? {
        Task {
            do {
            share = try await getShare()
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        if let share = share {
            let sharingController = UICloudSharingController(
                share: share,
                container: container
            )
            sharingController.availablePermissions = .allowPublic
            sharingController.modalPresentationStyle = .formSheet
            return sharingController
            
        } else {
            return nil
        }
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
    
    func isCloudFull(erroDescription: String) {
        if erroDescription.contains("Quota exceeded") {
            DispatchQueue.main.async {
                var dialogMessage = UIAlertController(title: "Erro", message: "Seu iCloud está cheio", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .cancel)
                dialogMessage.addAction(ok)
                let window = UIApplication.shared.keyWindow
                window?.rootViewController?.present(dialogMessage, animated: true)
            }
        }
    }
    func deleteAllRecords() async {
        // fetch records from iCloud, get their recordID and then delete them
        let arrayType = [Goal.getType(), User.getType(), Spent.getType(), MethodologyGoal.getType(), MethodologySpent.getType()]
        do {
            let predicate = NSPredicate(value: true)
            for type in arrayType {
                let records = try await fetchSharedPrivatedRecords(recordType: type, predicate: predicate)
                for record in records {
                    do {
                        try await container.privateCloudDatabase.deleteRecord(withID: record.recordID)
                    } catch {
                        do {
                            try await container.sharedCloudDatabase.deleteRecord(withID: record.recordID)
                        } catch {
                            print("deleteAllRecord")
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        } catch let error {
            print("fecthDeleteAllRecords")
            print(error.localizedDescription)
        }
    }
}

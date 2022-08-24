//
//  MainViewModel.swift
//  UMKM
//
//  Created by Kevin  Dwi on 24/08/22.
//

import Foundation
import CloudKit
import Combine
import UIKit
import SwiftUI

enum RecordType: String {
    case user = "UsersData"
}

final class MainViewModel: ObservableObject{
    private var database: CKDatabase
    private var container: CKContainer
    
    @Published var isSignedInToiCloud: Bool = false
    @Published var userID: String = ""
    
    
    let objectWillChange = PassthroughSubject<(), Never>()
    
    init(container: CKContainer) {
        self.container = container
        self.database = self.container.publicCloudDatabase
        iCloudUserIDAsync()
       
    }
    
    func iCloudUserIDAsync() {
        // FETCH ID OF DEVICE ACCOUNT
        container.fetchUserRecordID { returnedID, returnedError in
            if let returnedError = returnedError {
                print("Error: \(returnedError)")
            } else {
                if let returnedID = returnedID?.recordName {
                    self.isSignedInToiCloud = true
                    self.userID = returnedID
                    
//                    print("uid : \(returnedID)")
                }
            }
        }
    }
    
    func fetchUserID() {
        // FETCH ID OF REGISTRATED ACCOUNT FROM DB
        let referenceField = "userID"
        let uid = self.userID
        let refID = CKRecord.ID(recordName: uid)
        let ref = CKRecord.Reference(recordID: refID, action: .none)
        let predicate = NSPredicate(format: "iCloudID == %@", self.userID)
        let query = CKQuery(recordType: RecordType.user.rawValue, predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        self.database.fetch(withQuery: query) { result in
            switch result {
            case .success(let result):
                result.matchResults.compactMap { $0.1 }
                    .forEach {
                        switch $0 {
                        case .success(let record):
                            self.userID = record.recordID.recordName
                            print("UID DISINI : \(self.userID)")
                        case .failure(let error):
                            print(error)
                        }
                    }
            case .failure(let error):
                print(error)
            }
        }
    }
}

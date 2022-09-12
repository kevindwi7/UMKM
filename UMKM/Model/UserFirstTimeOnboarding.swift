//
//  UserFirstTimeOnboarding.swift
//  UMKM
//
//  Created by Kevin  Dwi on 11/09/22.
//

import Foundation
import CloudKit

struct UserFirstTimeOnboarding{
    let id: CKRecord.ID?
    var userID: String
    var isFirstTime: Bool
    
    init(id: CKRecord.ID? = nil, userID: String ,isFirstTime: Bool){
        self.id = id
        self.userID = userID
        self.isFirstTime = isFirstTime
    }
    
    func toDictionary() -> [String: Any]{
        return ["userID": userID, "isFirstTime": isFirstTime]
    }
    
    static func fromRecord(_ record: CKRecord) -> UserFirstTimeOnboarding? {
        guard
            
            let userID = record.value(forKey: "userID") as? String,
            let IsFirstTime = record.value(forKey: "isFirstTime") as? Bool
              
        else {
            return nil
        }
        
        return UserFirstTimeOnboarding(id: record.recordID, userID: userID, isFirstTime: IsFirstTime)
        
    }
}

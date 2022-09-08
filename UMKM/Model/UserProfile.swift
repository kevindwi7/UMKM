//
//  UserProfile.swift
//  UMKM
//
//  Created by Kevin  Dwi on 08/09/22.
//

import Foundation
import CloudKit

struct UserProfile{
    let id: CKRecord.ID?
    let userID: String
    var userName: String
    var komunitas: String
    let pengalaman: String
    let divisi: String
    let isFirstTime: Bool

    
    init(id: CKRecord.ID? = nil, userID : String, userName : String, komunitas: String, pengalaman : String, divisi: String, isFirstTime: Bool){
        self.id = id
        self.userID = userID
        self.userName = userName
        self.komunitas = komunitas
        self.pengalaman = pengalaman
        self.divisi = divisi
        self.isFirstTime = isFirstTime
        
    
    }
    
    func toDictionary() -> [String: Any]{
        return ["userID": userID, "userName": userName, "komunitas": komunitas, "pengalaman":pengalaman,"divisi":divisi,"isFirstTime":isFirstTime]
    }
    
    static func fromRecord(_ record: CKRecord) -> UserProfile? {
        guard
            
            let userID = record.value(forKey: "userID") as? String,
            let userName = record.value(forKey: "userName") as? String,
            let komunitas = record.value(forKey: "komunitas") as? String,
            let pengalaman = record.value(forKey: "pengalaman") as? String,
            let divisi = record.value(forKey: "divisi") as? String,
            let isFirstTime = record.value(forKey: "isFirstTime") as? Bool
                
        else {
            return nil
        }
        
        return UserProfile(id: record.recordID, userID: userID, userName: userName, komunitas: komunitas, pengalaman: pengalaman, divisi: divisi, isFirstTime: isFirstTime)
    }
}

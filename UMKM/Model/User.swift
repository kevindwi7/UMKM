//
//  User.swift
//  UMKM
//
//  Created by Trevincen Tambunan on 06/09/22.
//

import Foundation
import CloudKit

struct UsersData{
    let id: CKRecord.ID?
    var firstName: String
    let email: String
    var lastName: String
    let iCloudID: String

    
    init(id: CKRecord.ID? = nil, firstName: String ,email: String, lastName: String, iCloudID:String){
        self.id = id
        self.firstName = firstName
        self.email = email
        self.lastName = lastName
        self.iCloudID = iCloudID
    
    }
    
    func toDictionary() -> [String: Any]{
        return ["firstName": firstName, "email": email, "lastName": lastName, "iCloudID":iCloudID]
    }
    
    static func fromRecord(_ record: CKRecord) -> UsersData? {
        guard
            
            let firstName = record.value(forKey: "firstName") as? String,
            let email = record.value(forKey: "email") as? String,
            let lastName = record.value(forKey: "lastName") as? String,
            let iCloudID = record.value(forKey: "iCloudID") as? String
                
        else {
            return nil
        }
        
        return UsersData(id: record.recordID, firstName: firstName , email: email, lastName: lastName, iCloudID: iCloudID)
        
    }
}

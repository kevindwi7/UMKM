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
    let komunitas: String
    let divisi: String
    let pengalaman: String
    let isFirstTime: Bool
    
    init(id: CKRecord.ID? = nil, firstName: String ,email: String, lastName: String, iCloudID:String, komunitas: String, divisi: String, pengalaman: String, isFirstTime: Bool){
        self.id = id
        self.firstName = firstName
        self.email = email
        self.lastName = lastName
        self.iCloudID = iCloudID
        self.komunitas = komunitas
        self.divisi = divisi
        self.pengalaman = pengalaman
        self.isFirstTime = isFirstTime
    }
    
    func toDictionary() -> [String: Any]{
        return ["firstName": firstName, "email": email, "lastName": lastName, "iCloudID":iCloudID, "komunitas": komunitas, "divisi": divisi,"pengalaman": pengalaman, "isFirstTime": isFirstTime]
    }
    
    static func fromRecord(_ record: CKRecord) -> UsersData? {
        guard
            
            let firstName = record.value(forKey: "firstName") as? String,
            let email = record.value(forKey: "email") as? String,
            let lastName = record.value(forKey: "lastName") as? String,
            let iCloudID = record.value(forKey: "iCloudID") as? String,
            let komunitas = record.value(forKey: "komunitas") as? String,
            let divisi = record.value(forKey: "divisi") as? String,
            let pengalaman = record.value(forKey: "pengalaman") as? String,
            let isFirstTime = record.value(forKey: "isFirstTime") as? Bool

        else {
            return nil
        }
        
        return UsersData(id: record.recordID, firstName: firstName , email: email, lastName: lastName, iCloudID: iCloudID, komunitas: komunitas,divisi: divisi,pengalaman: pengalaman, isFirstTime: isFirstTime)
        
    }
}

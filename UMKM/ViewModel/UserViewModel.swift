//
//  UserViewModel.swift
//  UMKM
//
//  Created by Trevincen Tambunan on 06/09/22.
//

import Foundation
import CloudKit

struct UserViewModel{
    let user: UsersData
    
    var id: CKRecord.ID? {
        user.id
    }
    
    var firstName: String {
        user.firstName
    }
    
    var email: String {
        user.email
    }
    
    var lastName: String {
        user.lastName
    }
    
    var iCloudID:String {
        user.iCloudID
    }
    
    var divisi: String{
        user.divisi
    }
    
    var komunitas: String{
        user.komunitas
    }
    
    var pengalaman: String{
        user.pengalaman
    }
    
    var isFirstTime: Bool{
        user.isFirstTime
    }
}

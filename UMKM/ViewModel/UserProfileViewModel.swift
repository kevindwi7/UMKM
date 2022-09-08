//
//  UserProfileViewModel.swift
//  UMKM
//
//  Created by Kevin  Dwi on 08/09/22.
//

import Foundation
import CloudKit

struct UserProfileViewModel{
    let user: UserProfile
    
    var id: CKRecord.ID? {
        user.id
    }
    
    var userID: String {
        user.userID
    }
    
    var userName: String {
        user.userName
    }
    
    var komunitas: String {
        user.komunitas
    }
    
    var pengalaman:String {
        user.pengalaman
    }
    
    var divisi:String {
        user.divisi
    }
    
    var isFirstTime:Bool {
        user.isFirstTime
    }
    
}

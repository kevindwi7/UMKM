//
//  UserFirstTimeOnboardingViewModel.swift
//  UMKM
//
//  Created by Kevin  Dwi on 11/09/22.
//

import Foundation
import CloudKit

struct UserFirstTimeOnboardingViewModel: Hashable, Identifiable{
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(id.hashValue)
    }

    static func == (lhs: UserFirstTimeOnboardingViewModel, rhs: UserFirstTimeOnboardingViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    let userFirstTime: UserFirstTimeOnboarding
    
    var id: CKRecord.ID? {
        userFirstTime.id
    }
    
    var userID: String {
        userFirstTime.userID
    }
    
    var isFirstTime: Bool {
        userFirstTime.isFirstTime
    }
   
    
}

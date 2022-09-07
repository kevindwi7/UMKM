//
//  OnboardingViewModel.swift
//  UMKM
//
//  Created by Trevincen Tambunan on 07/09/22.
//

import Foundation

class OnboardingViewModel{
    private static var myStorageUserBool: String = "myStorageUserBool"
    
    public static var myUserBool: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: myStorageUserBool)
        }
        get {
            return UserDefaults.standard.object(forKey: myStorageUserBool) as? Bool ?? false
        }
    }
}

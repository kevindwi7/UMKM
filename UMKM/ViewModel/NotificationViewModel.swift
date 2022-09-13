//
//  NotificationViewModel.swift
//  UMKM
//
//  Created by Trevincen Tambunan on 11/09/22.
//

import SwiftUI
import UserNotifications
import CloudKit

class notificationViewModel:ObservableObject{
    func requestNotificationPermission(completion:@escaping((String?) -> ())){
        let option:UNAuthorizationOptions = [.badge,.sound,.alert]
        
        UNUserNotificationCenter.current().requestAuthorization(options: option) { success, error in
            if let error = error{
                print(error)
            }else{
                print("success")
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
                UserDefaults.standard.set(true, forKey: "notification")
                completion("Success")
                
            }
        }
    }
    
    
    func subscribeToNotifications(){
        print(123)
        let predicate = NSPredicate(value: true)
        let subscription = CKQuerySubscription(recordType: RecordType.project.rawValue, predicate: predicate, subscriptionID: "project_added_to_databse", options: .firesOnRecordCreation)
        
        let notification = CKSubscription.NotificationInfo()
        notification.title = "There's a new project!"
        notification.alertBody = "Open the app to check them out"
        notification.soundName = "default"
        
        subscription.notificationInfo = notification
        
        CKContainer.default().publicCloudDatabase.save(subscription) { returnedSubscription, returnedError in
            if let error = returnedError {
                print(error)
            }else{
                print("Success to subcribe")
            }
        }
        
    }
    
    func unsubscribeNotifications(){
        CKContainer.default().publicCloudDatabase.delete(withSubscriptionID: "project_added_to_databse") { returnedID, returnedError in
            if let error = returnedError{
                print(error)
            }else{
                print("Success Unsubscribe")
            }
        }
    }
}

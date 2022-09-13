//
//  Task.swift
//  UMKM
//
//  Created by Kevin  Dwi on 30/08/22.
//

import Foundation
import CloudKit

struct Task{
    let id: CKRecord.ID?
    let projectId: String
    var taskName: String
    var user: String
    var isFinish: Bool
    var registerUser: [String]
    var registerUserID: [String]
    var userID: String
    var projectName: String
  
    
    init(id: CKRecord.ID? = nil, projectId: String ,taskName: String, user: String, isFinish: Bool, registerUser:[String], registerUserID:[String], userID: String, projectName:String){
        self.id = id
        self.projectId = projectId
        self.taskName = taskName
        self.user = user
        self.isFinish = isFinish
        self.registerUser = registerUser
        self.registerUserID = registerUserID
        self.userID = userID
        self.projectName = projectName
    }
    
    func toDictionary() -> [String: Any]{
        return ["projectId": projectId, "taskName": taskName, "user": user, "isFinish": isFinish, "registerUser":registerUser, "registerUserID":registerUserID, "userID": userID, "projectName":projectName]
    }
    
    static func fromRecord(_ record: CKRecord) -> Task? {
        guard
            
            let projectId = record.value(forKey: "projectId") as? String,
            let taskName = record.value(forKey: "taskName") as? String,
            let user = record.value(forKey: "user") as? String,
            let isFinish = record.value(forKey: "isFinish") as? Bool,
            let registerUser = record.value(forKey: "registerUser") as? [String],
            let registerUserID = record.value(forKey: "registerUserID") as? [String],
            let userID = record.value(forKey: "userID") as? String,
            let projectName = record.value(forKey: "projectName") as? String
                
        else {
            return nil
        }
        
        return Task(id: record.recordID, projectId: projectId , taskName: taskName, user: user, isFinish: isFinish,registerUser: registerUser, registerUserID: registerUserID, userID: userID, projectName: projectName)
        
    }
}

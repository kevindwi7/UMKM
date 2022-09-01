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
  
    
    init(id: CKRecord.ID? = nil, projectId: String ,taskName: String, user: String){
        self.id = id
        self.projectId = projectId
        self.taskName = taskName
        self.user = user
      
    }
    
    func toDictionary() -> [String: Any]{
        return ["projectId": projectId, "taskName": taskName, "user": user]
    }
    
    static func fromRecord(_ record: CKRecord) -> Task? {
        guard
            
            let projectId = record.value(forKey: "projectId") as? String,
            let taskName = record.value(forKey: "taskName") as? String,
            let user = record.value(forKey: "user") as? String
        
                
        else {
            return nil
        }
        
        return Task(id: record.recordID, projectId: projectId , taskName: taskName, user: user)
        
    }
}

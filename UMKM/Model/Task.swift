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
  
    
    init(id: CKRecord.ID? = nil, projectId: String ,taskName: String, user: String, isFinish: Bool){
        self.id = id
        self.projectId = projectId
        self.taskName = taskName
        self.user = user
        self.isFinish = isFinish
      
    }
    
    func toDictionary() -> [String: Any]{
        return ["projectId": projectId, "taskName": taskName, "user": user, "isFinish": isFinish]
    }
    
    static func fromRecord(_ record: CKRecord) -> Task? {
        guard
            
            let projectId = record.value(forKey: "projectId") as? String,
            let taskName = record.value(forKey: "taskName") as? String,
            let user = record.value(forKey: "user") as? String,
            let isFinish = record.value(forKey: "isFinish") as? Bool
        
                
        else {
            return nil
        }
        
        return Task(id: record.recordID, projectId: projectId , taskName: taskName, user: user, isFinish: isFinish)
        
    }
}

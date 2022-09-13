//
//  TaskViewModel.swift
//  UMKM
//
//  Created by Kevin  Dwi on 30/08/22.
//

import Foundation
import CloudKit

struct TaskViewModel: Hashable, Identifiable{
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(id.hashValue)
    }

    static func == (lhs: TaskViewModel, rhs: TaskViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    let task: Task
    
    var id: CKRecord.ID? {
        task.id
    }
    
    var projectId: String {
        task.projectId
    }
    
    var taskName: String {
        task.taskName
    }
    
    var user: String {
        task.user
    }
    
    var isFinish: Bool{
        task.isFinish
    }
    
    var registerUser: [String]{
        task.registerUser
    }
    
    
    var registerUserID: [String]{
        task.registerUserID
    }
    
    var userID: String{
        task.userID
    }
    var projectName: String{
        task.projectName
    }
}

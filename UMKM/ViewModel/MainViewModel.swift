//
//  MainViewModel.swift
//  UMKM
//
//  Created by Kevin  Dwi on 24/08/22.
//

import Foundation
import CloudKit
import Combine
import UIKit
import SwiftUI

enum RecordType: String {
    case project = "Project"
    case task = "Task"
    case user = "UsersData"
}

final class MainViewModel: ObservableObject{
    private var database: CKDatabase
    private var container: CKContainer
    
    @Published var projects: [ProjectViewModel] = []
    @Published var tasks: [TaskViewModel] = []
    
    @Published var isSignedInToiCloud: Bool = false
    @Published var recentlyCreatedProjectId: String = ""
    @Published var userID: String = ""
    @Published var isLoading: Bool = false
    
    let objectWillChange = PassthroughSubject<(), Never>()
    
    init(container: CKContainer) {
        self.container = container
        self.database = self.container.publicCloudDatabase
        iCloudUserIDAsync()
       
    }
    
    func iCloudUserIDAsync() {
        // FETCH ID OF DEVICE ACCOUNT
        container.fetchUserRecordID { returnedID, returnedError in
            if let returnedError = returnedError {
                print("Error: \(returnedError)")
            } else {
                if let returnedID = returnedID?.recordName {
                    self.isSignedInToiCloud = true
                    self.userID = returnedID
                    
//                    print("uid : \(returnedID)")
                }
            }
        }
    }
    
    func fetchUserID() {
        // FETCH ID OF REGISTRATED ACCOUNT FROM DB
        let referenceField = "userID"
        let uid = self.userID
        let refID = CKRecord.ID(recordName: uid)
        let ref = CKRecord.Reference(recordID: refID, action: .none)
        let predicate = NSPredicate(format: "iCloudID == %@", self.userID)
        let query = CKQuery(recordType: RecordType.user.rawValue, predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        self.database.fetch(withQuery: query) { result in
            switch result {
            case .success(let result):
                result.matchResults.compactMap { $0.1 }
                    .forEach {
                        switch $0 {
                        case .success(let record):
                            self.userID = record.recordID.recordName
                            print("UID DISINI : \(self.userID)")
                        case .failure(let error):
                            print(error)
                        }
                    }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func createProject(projectHost: String, projectName: String, location: String,  startTime: Date, endTime: Date, participantList: [String],  description: String, goal: String, hostId: String, isFinish: Bool, startDate:Date, endDate: Date , projectID: String
                       ,completionHandler:  @escaping () -> Void
    ){
        self.isLoading = true
        let record = CKRecord(recordType: RecordType.project.rawValue)
        let project = Project(projectHost: projectHost, projectName: projectName, goal: goal, description: description, location: location,  startTime: startTime, endTime: endTime, participantList: participantList, hostId: hostId, isFinish: isFinish, startDate: startDate, endDate: endDate, projectID: projectID)
        
        record.setValuesForKeys(project.toDictionary())
        
        // saving record in database
        self.database.save(record) { returnedRecord, returnedError in
            if let returnedError = returnedError {
                print("Error: \(returnedError)")
            } else {
                if let returnedRecord = returnedRecord {
                    if let project = Project.fromRecord(returnedRecord) {
                        DispatchQueue.main.async {
                            self.isLoading = false
                            self.projects.append(ProjectViewModel(project: project))
                            self.objectWillChange.send()
                           
                        }
//                        self.recentlyCreatedProjectId = project.projectID
//                        print("---- ROOM ID NYA INI : \(self.recentlyCreatedProjectId) -----")
                        completionHandler()
//                        self.recentlyCreatedProjectId = project.id?.recordName ?? ""
//                        completionHandler(self.recentlyCreatedProjectId)
                        
                    }
                }
            }
        }
    }
    
    func createTask(projectId: String,taskName: String, user: String)   {
        
        let record = CKRecord(recordType: RecordType.task.rawValue)
        let task = Task(projectId: projectId, taskName: taskName, user: user)
        
        record.setValuesForKeys(task.toDictionary())
        
        // saving record in database
        self.database.save(record) { returnedRecord, returnedError in
            if let returnedError = returnedError {
                print("Error: \(returnedError)")
            } else {
                if let returnedRecord = returnedRecord {
                    if let task = Task.fromRecord(returnedRecord) {
                        DispatchQueue.main.async {
                            self.tasks.append(TaskViewModel(task: task))
                            self.objectWillChange.send()
                            
                        }
                    }
                }
            }
        }
    }
    
    func fetchTask(){
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: RecordType.task.rawValue, predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        var returnedTasks: [Task] = []
        
        self.database.fetch(withQuery: query) { result in
            switch result {
            case .success(let result):

                result.matchResults.compactMap { $0.1 }
                    .forEach {
                        switch $0 {
                        case .success(let record):
                            
                            if let task = Task.fromRecord(record) {
                                returnedTasks.append(task)
                            }
//                            print(returnedRooms)
                        case .failure(let error):
                            print(error)
                        }
                    }
                
                DispatchQueue.main.async {
                    self.tasks = returnedTasks.map(TaskViewModel.init)
//                    defer {
//                        self.objectWillChange.send()
//                    }
                    self.objectWillChange.send()
//                    print("\(self.rooms)")
                }

            case .failure(let error):
                print(error)
            }
        }
    }
}

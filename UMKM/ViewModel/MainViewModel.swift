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
    case userFirstTimeOnboarding = "UserFirstTimeOnboarding"
    case userProfile = "UserProfile"
}

final class MainViewModel: ObservableObject{
    private var database: CKDatabase
    private var container: CKContainer
    
    @Published var projects: [ProjectViewModel] = []
    @Published var tasks: [TaskViewModel] = []
    @Published var userTasks: [TaskViewModel] = []
    @Published var takenTasks: [TaskViewModel] = []
    
    //    @Published var usersProfile: [UserProfileViewModel] = []
    
    @Published var isSignedInToiCloud: Bool = false
    @Published var recentlyCreatedProjectId: String = ""
    @Published var userID: String = ""
    @Published var isLoading: Bool = false
    @Published var currentUser:UsersData?
    @Published var user:UserViewModel = UserViewModel(user: UsersData(firstName: "", email: "", lastName: "", iCloudID: "", komunitas: "", divisi: "", pengalaman: "", isFirstTime: true))
    //    @Published var user:UserViewModel?
    
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
                            //                            self.currentUser?.firstName = record.recordID
                            self.userID = record.recordID.recordName
                            //                            if let project = Project.fromRecord(record) {
                            //                                returnedProjects.append(project)
                            //                            }
                            if let currentUser = self.currentUser {
                                self.currentUser = currentUser
                            }
                            print(self.currentUser?.firstName ?? "Kosong")
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
                       ,participantListName: [String],divisi: String,completionHandler:  @escaping () -> Void
    ){
        self.isLoading = true
        let record = CKRecord(recordType: RecordType.project.rawValue)
        let project = Project(projectHost: projectHost, projectName: projectName, goal: goal, description: description, location: location,  startTime: startTime, endTime: endTime, participantList: participantList, hostId: hostId, isFinish: isFinish, startDate: startDate, endDate: endDate, projectID: projectID,participantListName: participantListName, divisi: divisi)
        
        record.setValuesForKeys(project.toDictionary())
        
        // saving record in database
        self.database.save(record) { returnedRecord, returnedError in
            print("return from create \(returnedError) \(returnedRecord)")
            if let returnedError = returnedError {
                print("Error: \(returnedError)")
            } else {
                if let returnedRecord = returnedRecord {
                    if let project = Project.fromRecord(returnedRecord) {
                        DispatchQueue.main.async {
                            
                            self.projects.append(ProjectViewModel(project: project))
                            self.objectWillChange.send()
                            
                        }
                        completionHandler()
                        //                        self.recentlyCreatedProjectId = project.projectID
                        //                        print("---- ROOM ID NYA INI : \(self.recentlyCreatedProjectId) -----")
                        
                        //                        self.recentlyCreatedProjectId = project.id?.recordName ?? ""
                        //                        completionHandler(self.recentlyCreatedProjectId)
                        
                    }
                }
            }
        }
    }
    
    func createTask(projectId: String,taskName: String, user: String, isFinish:Bool, registerUser: [String],registerUserID: [String], userID: String, projectName:String, completionHandler: @escaping () -> Void)   {
        
        let record = CKRecord(recordType: RecordType.task.rawValue)
        let task = Task(projectId: projectId, taskName: taskName, user: user, isFinish: isFinish, registerUser: registerUser, registerUserID: registerUserID, userID: userID, projectName: projectName)
        
        record.setValuesForKeys(task.toDictionary())
        print("masuk create task")
        // saving record in database
        self.database.save(record) { returnedRecord, returnedError in
            print("\(returnedRecord)")
            if let returnedError = returnedError {
                print("Error: \(returnedError)")
            } else {
                if let returnedRecord = returnedRecord {
                    if let task = Task.fromRecord(returnedRecord) {
                        DispatchQueue.main.async {
                            self.tasks.append(TaskViewModel(task: task))
                            self.objectWillChange.send()
                            self.isLoading = false
                        }
                        completionHandler()
                    }
                }
            }
        }
    }
    
    func finishProject(project: ProjectViewModel,isFinish:Bool){
        self.isLoading = true
        var newIsFinish =  Bool()
        
        newIsFinish = true
        
        let recordId = project.id
        
        database.fetch(withRecordID: recordId!) { returnedRecord, error in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                if let error = error {
                    print(error)
                }
                guard let record = returnedRecord else { return }
                
                record["isFinish"] = newIsFinish as CKRecordValue
                
                
                print("print: \(newIsFinish)")
                self.database.save(record) { record, error in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        if let error = error {
                            print(error)
                            
                        }
                        
                        guard let record = returnedRecord else { return }
                        
                        print("testttt")
                        self.isLoading = false
                        self.objectWillChange.send()
                        
                        
                    }
                }
            }
        }
        
    }
    
    func fetchTask(project: ProjectViewModel){
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
                                if task.projectId == project.projectID{
                                    returnedTasks.append(task)
                                }
                                
                            }
                            //                            print(returnedRooms)
                        case .failure(let error):
                            print(error)
                        }
                    }
                print("Task")
                DispatchQueue.main.async {
                    self.tasks = returnedTasks.map(TaskViewModel.init)
                    self.objectWillChange.send()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchUserTasks(userID:String){
        
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
                                guard let id = record["userID"] as? String else { return }
                                if(userID == id){
                                    returnedTasks.append(task)
                                    print("success")
                                }
                            }
                        case .failure(let error):
                            print(error)
                        }
                    }
                
                DispatchQueue.main.async {
                    self.userTasks = returnedTasks.map(TaskViewModel.init)
                    self.objectWillChange.send()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchTakenTasks(project:ProjectViewModel){
//        print(project)
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
                                if(task.projectId == project.projectID){
                                    if !task.userID.isEmpty{
                                        returnedTasks.append(task)
                                        print("Taken")
                                        print(task.projectName)
                                        print(task.user)
                                    }
                                }
                            }
                            //                            print(returnedRooms)
                        case .failure(let error):
                            print(error)
                        }
                    }
                print("Task")
                DispatchQueue.main.async {
                    self.takenTasks = returnedTasks.map(TaskViewModel.init)
                    self.objectWillChange.send()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
//    func fetchTask(project: ProjectViewModel){
//        let predicate = NSPredicate(value: true)
//        let query = CKQuery(recordType: RecordType.task.rawValue, predicate: predicate)
//        let queryOperation = CKQueryOperation(query: query)
//        queryOperation.qualityOfService = .userInitiated
//
//        var returnedTasks: [Task] = []
//
//        queryOperation.recordMatchedBlock = { id, result in
//            switch result {
//                case .success(let record):
//                if let task = Task.fromRecord(record) {
//                                                if task.projectId == project.projectID{
//                                                    returnedTasks.append(task)
//                                                }
//
//                                            }
//
//                    DispatchQueue.main.async {
//                        self.tasks = returnedTasks.map(TaskViewModel.init)
////                        self.tasks = self.tasks.sorted(by: {$0.startDate.compare($1.startDate) == .orderedAscending})
//                        self.objectWillChange.send()
//    //                    print("\(self.rooms)")
//                    }
//                    break
//                case .failure(let error):
//                    print(error)
//                    break
//            }
//        }
//
//        database.add(queryOperation)
//
////        self.database.fetch(withQuery: query) { result in
////            switch result {
////            case .success(let result):
////
////                result.matchResults.compactMap { $0.1 }
////                    .forEach {
////                        switch $0 {
////                        case .success(let record):
////
////                            if let task = Task.fromRecord(record) {
////                                if task.projectId == project.projectID{
////                                    returnedTasks.append(task)
////                                }
////
////                            }
////                            //                            print(returnedRooms)
////                        case .failure(let error):
////                            print(error)
////                        }
////                    }
//////                print("Task")
////                DispatchQueue.main.async {
////                    self.tasks = returnedTasks.map(TaskViewModel.init)
////                    self.objectWillChange.send()
////                }
////
////            case .failure(let error):
////                print(error)
////            }
////        }
//    }
}


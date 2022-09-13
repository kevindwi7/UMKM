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
    @Published var userFirstTimes: [UserFirstTimeOnboardingViewModel] = []
    @Published var userTasks: [TaskViewModel] = []
    //    @Published var usersProfile: [UserProfileViewModel] = []
    
    @Published var isSignedInToiCloud: Bool = false
    @Published var recentlyCreatedProjectId: String = ""
    @Published var userID: String = ""
    @Published var isLoading: Bool = false
    @Published var isLoadingUserProfile: Bool = false
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
                       ,participantListName: [String],completionHandler:  @escaping () -> Void
    ){
        self.isLoading = true
        let record = CKRecord(recordType: RecordType.project.rawValue)
        let project = Project(projectHost: projectHost, projectName: projectName, goal: goal, description: description, location: location,  startTime: startTime, endTime: endTime, participantList: participantList, hostId: hostId, isFinish: isFinish, startDate: startDate, endDate: endDate, projectID: projectID,participantListName: participantListName)
        
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
    
    func createTask(projectId: String,taskName: String, user: String, isFinish:Bool)   {
        
        let record = CKRecord(recordType: RecordType.task.rawValue)
        let task = Task(projectId: projectId, taskName: taskName, user: user, isFinish: isFinish)
        
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
    
    func finishTask(task: TaskViewModel, completionHandler:  @escaping () -> Void){
        self.isLoading = true
        let recordId = task.id
        let projectId = task.projectId
        let taskName = task.taskName
        let user = task.user
        
        let isFinish = true
        
        database.fetch(withRecordID: recordId!) { returnedRecord, error in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                if let error = error {
                    print(error)
                }
                guard let record = returnedRecord else { return }
                
                record["isFinish"] = isFinish as CKRecordValue
                self.database.save(record) { record, error in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        if let error = error {
                            print(error)
                        }
                        guard let record = returnedRecord else { return }
                        let id = record.recordID
                        guard let finishStatus = record["isFinish"] as? Bool else { return }
                        let element = TaskViewModel(task: Task(id: id, projectId: projectId, taskName: taskName, user: user, isFinish: finishStatus))
                        
                        //                        print(element)
                        self.isLoading = false
                        completionHandler()
                    }
                }
            }
        }
    }
    
    func createUserFirstTime(userID: String,isFirstTime: Bool)   {
        
        let record = CKRecord(recordType: RecordType.userFirstTimeOnboarding.rawValue)
        let userFirstTime = UserFirstTimeOnboarding(userID: userID, isFirstTime: isFirstTime)
        
        record.setValuesForKeys(userFirstTime.toDictionary())
        
        // saving record in database
        self.database.save(record) { returnedRecord, returnedError in
            if let returnedError = returnedError {
                print("Error: \(returnedError)")
            } else {
                if let returnedRecord = returnedRecord {
                    if let userFirstTimess = UserFirstTimeOnboarding.fromRecord(returnedRecord) {
                        DispatchQueue.main.async {
                            self.userFirstTimes.append(UserFirstTimeOnboardingViewModel(userFirstTime: userFirstTimess))
                            self.objectWillChange.send()
                            
                        }
                    }
                }
            }
        }
    }
    
    func fetchUserFirstTime(){
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: RecordType.userFirstTimeOnboarding.rawValue, predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        var returnedUserFirstTimes: [UserFirstTimeOnboarding] = []
        
        self.database.fetch(withQuery: query) { result in
            switch result {
            case .success(let result):
                
                result.matchResults.compactMap { $0.1 }
                    .forEach {
                        switch $0 {
                        case .success(let record):
                            
                            if let userFirstTime = UserFirstTimeOnboarding.fromRecord(record) {
                                
                                returnedUserFirstTimes.append(userFirstTime)
                                
                                
                            }
                            //                            print(returnedRooms)
                        case .failure(let error):
                            print(error)
                        }
                    }
                
                DispatchQueue.main.async {
                    self.userFirstTimes = returnedUserFirstTimes.map(UserFirstTimeOnboardingViewModel.init)
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
    
    func fetchAllTask(userID:String){
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
                            print("Success")
                            if let task = Task.fromRecord(record){
                                let taskUser = record["user"] as! String
                                if taskUser == userID{
                                    returnedTasks.append(task)
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
    
    
    //    func fetchUserProfile(){
    //
    //        let predicate = NSPredicate(value: true)
    //        let query = CKQuery(recordType: RecordType.userProfile.rawValue, predicate: predicate)
    //        let queryOperation = CKQueryOperation(query: query)
    //
    //        var returnedUsersProfile: [UserProfile] = []
    //
    //        self.database.fetch(withQuery: query) { result in
    //            switch result {
    //            case .success(let result):
    //
    //                result.matchResults.compactMap { $0.1 }
    //                    .forEach {
    //                        switch $0 {
    //                        case .success(let record):
    //
    //                            if let user = UserProfile.fromRecord(record) {
    //                                returnedUsersProfile.append(user)
    //                            }
    ////                            print(returnedRooms)
    //                        case .failure(let error):
    //                            print(error)
    //                        }
    //                    }
    //
    //                DispatchQueue.main.async {
    //                    self.usersProfile = returnedUsersProfile.map(UserProfileViewModel.init)
    ////                    defer {
    ////                        self.objectWillChange.send()
    ////                    }
    //                    self.objectWillChange.send()
    ////                    print("\(self.rooms)")
    //                }
    //
    //            case .failure(let error):
    //                print(error)
    //            }
    //        }
    //    }
}

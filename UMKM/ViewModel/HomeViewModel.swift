//
//  HomeViewModel.swift
//  UMKM
//
//  Created by Trevincen Tambunan on 25/08/22.
//

import Foundation
import CloudKit
import Combine
import UIKit
import SwiftUI

class HomeViewModel:ObservableObject{
    
    private var database: CKDatabase
    private var container: CKContainer
    
    @Published var projects: [ProjectViewModel] = [ProjectViewModel]()
    @Published var tasks: [TaskViewModel] = []
    @Published var users: [UserViewModel] = []
    
    
    @Published var isLoading: Bool = false
    @Published var isFirstTime: Bool = false
    @Published var hasUpdated: Bool = false
    
    init(container: CKContainer) {
        self.container = container
        self.database = self.container.publicCloudDatabase
       
    }
    
    func fetchProject(){
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: RecordType.project.rawValue, predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        var returnedProjects: [Project] = []
        
        self.database.fetch(withQuery: query) { result in
            switch result {
            case .success(let result):

                result.matchResults.compactMap { $0.1 }
                    .forEach {
                        switch $0 {
                        case .success(let record):
                            
                            if let project = Project.fromRecord(record) {
                                returnedProjects.append(project)
                            }
//                            print(returnedRooms)
                        case .failure(let error):
                            print(error)
                        }
                    }
                
                DispatchQueue.main.async {
                    self.projects = returnedProjects.map(ProjectViewModel.init)
//                    self.fetchTask()
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
    
    func updateProjectMember(project: ProjectViewModel,task: TaskViewModel, participantID: String, participantName: String, userID: String, userName: String,userRegister: String,  userRegisterID: String, completionHandler:  @escaping () -> Void){
        
        self.isLoading = true
        
        var newParticipantID =  [String]()
        var newParticipantName = [String]()
        var newUserName = String()
        var newUserID = String()
        var newRegisterUser =  [String]()
        var newRegisterUserID =  [String]()
        
        newParticipantID.insert(contentsOf: project.participantList, at: 0)
        newParticipantName.insert(contentsOf: project.participantListName, at: 0)
        newRegisterUser.insert(contentsOf: task.registerUser, at: 0)
        newRegisterUserID.insert(contentsOf: task.registerUserID, at: 0)
        
        newUserName = userName
        newUserID = userID

        let recordId = project.id
        let recordId2 = task.id
        
        let userName = task.user
        let userID = task.userID
        
      
//
//
        if( !(newParticipantID.contains(participantID)) || !(newParticipantName.contains(participantName)) || !(newUserName.contains(userName)) || !(newUserID.contains(userID)) || newRegisterUser.contains(userRegister) || newRegisterUserID.contains(userRegisterID)){
            if let index2 = newRegisterUser.firstIndex(of: userRegister), let index1 = newRegisterUserID.firstIndex(of: userRegisterID){
                print("\(newRegisterUser[index1])")
                print("\(newRegisterUser[index2])")
                newRegisterUser.remove(at: index1)
                newRegisterUserID.remove(at: index2)
            }
            if(participantID != "" || !(participantID.isEmpty) || participantName != "" || !(participantName.isEmpty) || userName != "" || !(userName.isEmpty) || userID != "" || !(userID.isEmpty) ){
                newParticipantID.append(participantID)
                newParticipantName.append(participantName)
                newUserName.append(userName)
                newUserID.append(userID)
                    print("masukk")
                }

        }

        newParticipantID.removeAll(where: { $0 == "" })
        newParticipantName.removeAll(where: { $0 == "" })
        newRegisterUser.removeAll(where: { $0 == "" })
        newRegisterUserID.removeAll(where: { $0 == "" })
        
        print(newRegisterUser)
        print(newRegisterUserID)
        print(newParticipantID)
        
        
        database.fetch(withRecordID: recordId!) { returnedRecord, error in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                if let error = error {
                    print(error)
                }
                guard let record = returnedRecord else { return }
                
                record["participantList"] = newParticipantID as CKRecordValue
                record["participantListName"] = newParticipantName as CKRecordValue
                
                self.database.save(record) { record, error in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        if let error = error {
                            print(error)
                            
                        }

                        self.hasUpdated = true
                        self.isLoading =  false
                        self.objectWillChange.send()
                    }
                }
            }
        }
        
        database.fetch(withRecordID: recordId2!) { returnedRecord, error in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                if let error = error {
                    print(error)
                }
                guard let record = returnedRecord else { return }
                
                record["user"] = newUserName as CKRecordValue
                record["userID"] = newUserID as CKRecordValue
                
                record["registerUser"] = newRegisterUser as CKRecordValue
                record["registerUserID"] = newRegisterUserID as CKRecordValue
                
                self.database.save(record) { record, error in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        if let error = error {
                            print(error)
                            
                        }
                    
                        self.hasUpdated = true
                        self.isLoading =  false
                        completionHandler()
                    }
                }
            }
        }
    }
    
    func deleteTaskRegisterUserAccept(task: TaskViewModel, userRegister: String,  userRegisterID: String, completionHandler:  @escaping () -> Void){
        self.isLoading = true
        var newRegisterUser =  [String]()
        var newRegisterUserID =  [String]()
        
        newRegisterUser.insert(contentsOf: task.registerUser, at: 0)
        newRegisterUserID.insert(contentsOf: task.registerUserID, at: 0)
        
        let recordId = task.id
        
        if(newRegisterUser.contains(userRegister) || newRegisterUserID.contains(userRegisterID)){
            if let index2 = newRegisterUser.firstIndex(of: userRegister), let index1 = newRegisterUserID.firstIndex(of: userRegisterID){
                print("\(newRegisterUser[index1])")
                print("\(newRegisterUser[index2])")
                newRegisterUser.remove(at: index1)
                newRegisterUserID.remove(at: index2)
            }
//
        }
        
        newRegisterUser.removeAll(where: { $0 == "" })
        newRegisterUserID.removeAll(where: { $0 == "" })
        
        print(newRegisterUser)
        print(newRegisterUserID)
        
        database.fetch(withRecordID: recordId!) { returnedRecord, error in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                if let error = error {
                    print(error)
                }
                guard let record = returnedRecord else { return }
                
                record["registerUser"] = newRegisterUser as CKRecordValue
                record["registerUserID"] = newRegisterUserID as CKRecordValue
                
                print("dispatch")
                self.database.save(record) { record, error in
                    print("saveee")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        if let error = error {
                            print(error)
                            
                        }
                        self.isLoading =  false
                        guard let record = returnedRecord else { return }
//
                        print(123)
//
                        self.hasUpdated = true
                        
                        completionHandler()
                        
                    }
                }
            }
        }
      
    }
    
    func deleteProject(project: ProjectViewModel){
        self.isLoading = true
        let recordId = project.id
        database.delete(withRecordID: recordId!) { deletedRecordId, error in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                } else {
                    self.isLoading = false
                    
                }
                print("here")
            }
        }
    }
    
    func deleteTaskRegisterUser(task: TaskViewModel, userRegister: String,  userRegisterID: String){
        self.isLoading = true
        var newRegisterUser =  [String]()
        var newRegisterUserID =  [String]()
        
        newRegisterUser.insert(contentsOf: task.registerUser, at: 0)
        newRegisterUserID.insert(contentsOf: task.registerUserID, at: 0)
        
        let recordId = task.id
        
        if(newRegisterUser.contains(userRegister) || newRegisterUserID.contains(userRegisterID)){
            if let index2 = newRegisterUser.firstIndex(of: userRegister), let index1 = newRegisterUserID.firstIndex(of: userRegisterID){
                print("\(newRegisterUser[index1])")
                print("\(newRegisterUser[index2])")
                newRegisterUser.remove(at: index1)
                newRegisterUserID.remove(at: index2)
            }
//
        }
        
        newRegisterUser.removeAll(where: { $0 == "" })
        newRegisterUserID.removeAll(where: { $0 == "" })
        
        print(newRegisterUser)
        print(newRegisterUserID)
        
        database.fetch(withRecordID: recordId!) { returnedRecord, error in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                if let error = error {
                    print(error)
                }
                guard let record = returnedRecord else { return }
                
                record["registerUser"] = newRegisterUser as CKRecordValue
                record["registerUserID"] = newRegisterUserID as CKRecordValue
                
                print("dispatch")
                self.database.save(record) { record, error in
                    print("saveee")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        if let error = error {
                            print(error)
                            
                        }
                        self.isLoading =  false
                        guard let record = returnedRecord else { return }
//                        let id = record.recordID
//                        guard let user = record["user"] as? [String] else { return }
//                        guard let userID = record["user"] as? [String] else { return }
//
//                        let element = TaskViewModel(task: Task(id: id, projectId: projectId, taskName: taskName, user: userss, isFinish: isFinish, registerUser: user, registerUserID: <#[String]#>))
                        print(123)
//                        print(element)
                        self.hasUpdated = true
                      
                        
                        self.objectWillChange.send()
                        
                    }
                }
            }
        }
      
    }
    
    func updateTaskRegisterUser(task: TaskViewModel, user: String, userRegisterID: String, userID: String, command: String){
        self.isLoading = true
        var newRegisterUser =  [String]()
        var newRegisterUserID =  [String]()
        var newUserID = String()
        
        newRegisterUser.insert(contentsOf: task.registerUser, at: 0)
        newRegisterUserID.insert(contentsOf: task.registerUserID, at: 0)
        newUserID = userID
        
        let recordId = task.id
        let projectId = task.projectId
        let taskName = task.taskName
        let isFinish = task.isFinish
        let userss = task.user
    
        if (command == "join"){
            if(!(newRegisterUser.contains(user)) || !(newRegisterUserID.contains(userRegisterID)) ){
                if(user != "" || !(user.isEmpty) || (userRegisterID != "") || !(userID.isEmpty)){
                    print(222)
                    
                    newRegisterUser.append(user)
                    newRegisterUserID.append(userRegisterID)
                    newUserID.append(userID)
                        print("masukk")
                }
                
            }
        }else if (command == "delete") {
            if(newRegisterUser.contains(userRegisterID) || newRegisterUserID.contains(userRegisterID)){
                if let index = newRegisterUser.firstIndex(of: userRegisterID)  {
                    print("Leave Room : \(newRegisterUser[index])")
                    newRegisterUser.remove(at: index)
                }
                if let index2 = newRegisterUserID.firstIndex(of: userRegisterID){
                    print("Leave Room : \(newRegisterUserID[index2])")
                    newRegisterUserID.remove(at: index2)
                }
            }
        }
       
        
        newRegisterUser.removeAll(where: { $0 == "" })
        newRegisterUserID.removeAll(where: { $0 == "" })
        
        print(newRegisterUser)
        print(newRegisterUserID)
        database.fetch(withRecordID: recordId!) { returnedRecord, error in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                if let error = error {
                    print(error)
                }
                guard let record = returnedRecord else { return }
                
                record["registerUser"] = newRegisterUser as CKRecordValue
                record["registerUserID"] = newRegisterUserID as CKRecordValue
                record["userID"] = newUserID as CKRecordValue
                
                print("dispatch")
                self.database.save(record) { record, error in
                    print("saveee")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        if let error = error {
                            print(error)
                            
                        }
                        self.isLoading =  false
                        guard let record = returnedRecord else { return }
                        let id = record.recordID
//                        guard let user = record["user"] as? [String] else { return }
//                        guard let userID = record["user"] as? [String] else { return }
//                        
//                        let element = TaskViewModel(task: Task(id: id, projectId: projectId, taskName: taskName, user: userss, isFinish: isFinish, registerUser: user, registerUserID: <#[String]#>))
                        print(123)
//                        print(element)
                        self.hasUpdated = true
                      
                        
                        self.objectWillChange.send()
                        
                    }
                }
            }
        }
    }
    
    func fetchAllUser(){
//        print(222)
        self.isLoading = true
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: RecordType.user.rawValue, predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        var returnedUsers: [UsersData] = []
        
        self.database.fetch(withQuery: query) { result in
            switch result {
            case .success(let result):
                result.matchResults.compactMap { $0.1 }
                    .forEach {
                        switch $0 {
                        case .success(let record):
                            if let user = UsersData.fromRecord(record) {
                                returnedUsers.append(user)
                                print(123)
                            }
//                            print(returnedRooms)
                        case .failure(let error):
                            print(error)
                        }
                    }
                
                DispatchQueue.main.async {
                    self.users = returnedUsers.map(UserViewModel.init)
                    self.isLoading = false
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
    
    func updateUserOnboarding(users: UserViewModel, komunitas: String,divisi: String, pengalaman: String, isFirstTime: Bool, completionHandler:  @escaping () -> Void){
       
        var newKomunitas =  String()
        var newdivisi =  String()
        var newPengalaman =  String()
        var newIsFirstTime =  Bool()
        
        newKomunitas = komunitas
        newdivisi = divisi
        newPengalaman = pengalaman
        newIsFirstTime = false
        
        let recordId = users.id
        let komunitas = users.komunitas
        let divisi = users.divisi
        let pengalaman = users.pengalaman

        if(!(newKomunitas.contains(komunitas)) || !(newdivisi.contains(divisi)) || !(newPengalaman.contains(pengalaman))){
            print(222)
            self.isLoading = true
                newKomunitas.append(komunitas)
                newdivisi.append(divisi)
                newIsFirstTime = false
                newPengalaman.append(pengalaman)
                print("masukk")
            
//            }
        }
        
        database.fetch(withRecordID: recordId!) { returnedRecord, error in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                if let error = error {
                    print(error)
                }
                guard let record = returnedRecord else { return }
                
                record["komunitas"] = newKomunitas as CKRecordValue
                record["divisi"] = newdivisi as CKRecordValue
                record["pengalaman"] = newPengalaman as CKRecordValue
                record["isFirstTime"] = newIsFirstTime as CKRecordValue
                
                
                print("print: \(newKomunitas)")
                self.database.save(record) { record, error in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        if let error = error {
                            print(error)
                            
                        }
                        guard let record = returnedRecord else { return }
                        let id = record.recordID
                        guard let komunitas = record["komunitas"] as? String else { return }
                        guard let divisi = record["divisi"] as? String else { return }
                        guard let pengalaman = record["pengalaman"] as? String else { return }

                        print("testttt")
                        
                        UserDefaults.standard.set(false, forKey: "isFirstTime")
//                        print(element)
                        self.hasUpdated = true
                        self.isLoading =  false
                        self.isFirstTime = false
                        
                        self.objectWillChange.send()
                        completionHandler()
                        
                    }
                }
            }
        }
        
    }
    
    
}

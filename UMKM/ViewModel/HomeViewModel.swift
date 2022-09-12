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
                    self.fetchTask()
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
    
    func updateProjectMember(project: ProjectViewModel, participantID: String, command: String){
        
        self.isLoading = true
        
        var newParticipant =  [String]()
        newParticipant.insert(contentsOf: project.participantList, at: 0)
        
        let recordId = project.id
        let projectHost = project.projectHost
        let projectName = project.projectName
        let hostId = project.hostId
        let goal = project.goal
        let description = project.description
        let location = project.location
        let startTime = project.startTime
        let endTime = project.endTime
        let isFinish = project.isFinish
        let startDate = project.startDate
        let endDate = project.endDate
        let projectID = project.projectID
        let participantListName = project.participantListName
        let divisi = project.divisi
        
        if(command == "join") {
            if( !(newParticipant.contains(participantID))){
                if(participantID != "" || !(participantID.isEmpty) ){
                    newParticipant.append(participantID)
                    print("masukk")
                }
            }
        } else if (command == "leave") {
            if(newParticipant.contains(participantID)){
                if let index = newParticipant.firstIndex(of: participantID) {
                    print("Leave Room : \(newParticipant[index])")
                    newParticipant.remove(at: index)
                }
            }
        }
        
        newParticipant.removeAll(where: { $0 == "" })
        
        print(newParticipant)
        database.fetch(withRecordID: recordId!) { returnedRecord, error in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                if let error = error {
                    print(error)
                }
                guard let record = returnedRecord else { return }
                
                record["participantList"] = newParticipant as CKRecordValue
                
                self.database.save(record) { record, error in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        if let error = error {
                            print(error)
                            
                        }
                        guard let record = returnedRecord else { return }
                        let id = record.recordID
                        guard let participantList = record["participantList"] as? [String] else { return }
                        let element = ProjectViewModel(project: Project(id: id, projectHost: projectHost, projectName: projectName, goal: goal, description: description, location: location, startTime: startTime, endTime: endTime, participantList: participantList, hostId: hostId, isFinish: isFinish, startDate: startDate, endDate: endDate, projectID: projectID, participantListName: participantListName, divisi: divisi))
//                        print(element)
                        self.hasUpdated = true
                        self.isLoading =  false
                        
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
    
    func fetchTask(){
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: RecordType.task.rawValue, predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        var returnedTasks: [Task] = []
        
//        projects[0].projectName = "asdas"
        self.database.fetch(withQuery: query) { result in
            switch result {
            case .success(let result):

                result.matchResults.compactMap { $0.1 }
                    .forEach {
                        switch $0 {
                        case .success(let record):
                            
                            if let task = Task.fromRecord(record) {
                                for i in 0 ..< self.projects.count{
                                    if self.projects[i].projectID == task.projectId{
//                                        returnedTasks.append(task)
//                                        self.projects[i].projectName = "ASD"
//                                        self.projects[i].tasks.append(TaskViewModel(task: task))
                                    }
                                }
                                
//                                returnedTasks.append(task)
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
                    
                    // Cek Task id dari projectID
                    
//                    }
                    self.objectWillChange.send()
//                    print("\(self.rooms)")
                }

            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateTaskParticipant(task: TaskViewModel, user: String, command: String){
        
        self.isLoading = true
        
        var newParticipant =  String()

        newParticipant.insert(contentsOf: task.user, at: newParticipant.startIndex )
        
        let recordId = task.id
        let projectId = task.projectId
        let taskName = task.taskName
        let isFinish = task.isFinish
        if(command == "join") {
            if( !(newParticipant.contains(user))){
                if(user != "" || !(user.isEmpty) ){
                    newParticipant.append(user)
                    print("masukk")
                }
            }
        }
        
        print(newParticipant)
        database.fetch(withRecordID: recordId!) { returnedRecord, error in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                if let error = error {
                    print(error)
                }
                guard let record = returnedRecord else { return }
                
                record["user"] = newParticipant as CKRecordValue
                
                self.database.save(record) { record, error in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        if let error = error {
                            print(error)
                            
                        }
                        guard let record = returnedRecord else { return }
                        let id = record.recordID
                        guard let user = record["user"] as? String else { return }
                        let element = TaskViewModel(task: Task(id: id, projectId: projectId, taskName: taskName, user: user, isFinish: isFinish))
                        print(123)
//                        print(element)
                        self.hasUpdated = true
                        self.isLoading =  false
                        
                        self.objectWillChange.send()
                        
                    }
                }
            }
        }
    }
    
    func fetchAllUser(){
//        print(222)
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

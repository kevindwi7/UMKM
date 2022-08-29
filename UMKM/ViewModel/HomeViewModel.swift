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
    @Published var projects: [ProjectViewModel] = []
    
    @Published var isLoading: Bool = false
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
        let participant = project.participant
        let isFinish = project.isFinish
        
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
                        let element = ProjectViewModel(project: Project(id: id, projectHost: projectHost, projectName: projectName, goal: goal, description: description, location: location, participant: participant, startTime: startTime, endTime: endTime, participantList: participantList, hostId: hostId, isFinish: isFinish))
//                        print(element)
                        self.hasUpdated = true
                        self.isLoading =  false
                        
                    }
                }
            }
        }
    }
    
    func deleteRoom(project: ProjectViewModel){
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
    
}

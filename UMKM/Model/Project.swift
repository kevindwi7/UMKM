//
//  Project.swift
//  UMKM
//
//  Created by Kevin  Dwi on 24/08/22.
//

import Foundation
import CloudKit

struct Project{
    let id: CKRecord.ID?
    let projectHost: String
    var projectName: String
    var goal: String
    var description: String
    var location: String
    var startTime: Date
    var endTime: Date
    var participantList: [String]
    var hostiD: String
    var isFinish: Bool
    var startDate: Date
    var endDate: Date
    var projectID: String
    
    init(id: CKRecord.ID? = nil, projectHost: String,projectName: String, goal: String, description: String, location: String,  startTime: Date, endTime: Date, participantList: [String], hostId: String, isFinish: Bool, startDate: Date, endDate: Date, projectID: String){
        self.id = id
        self.projectHost = projectHost
        self.projectName = projectName
        self.goal = goal
        self.description = description
        self.location = location
        self.startTime = startTime
        self.endTime = endTime
        self.participantList = participantList
        self.hostiD = hostId
        self.isFinish = isFinish
        self.startDate = startDate
        self.endDate = endDate
        self.projectID = projectID
    }
    
    func toDictionary() -> [String: Any]{
        return ["projectHost": projectHost, "projectName": projectName, "location": location, "goal": goal,"description": description,"startTime": startTime,"endTime": endTime, "participantList": participantList, "hostId": hostiD, "isFinish": isFinish, "startDate": startDate, "endDate": endDate, "projectID": projectID]
    }
    
    static func fromRecord(_ record: CKRecord) -> Project? {
        guard
            let projectHost = record.value(forKey: "projectHost") as? String,
            let projectName = record.value(forKey: "projectName") as? String,
            let goal = record.value(forKey: "goal") as? String,
            let description = record.value(forKey: "description") as? String,
            let location = record.value(forKey: "location") as? String,
            let startTime = record.value(forKey: "startTime") as? Date,
            let endTime = record.value(forKey: "endTime") as? Date,
            let description = record.value(forKey: "description") as? String,
            let participantList = record.value(forKey: "participantList") as? [String],
            let hostId = record.value(forKey: "hostId") as? String,
            let isFinish = record.value(forKey: "isFinish") as? Bool,
            let startDate = record.value(forKey: "startDate") as? Date,
            let endDate = record.value(forKey: "endDate") as? Date,
            let projectID = record.value(forKey: "projectID") as? String
                
        else {
            return nil
        }
        
        return Project(id: record.recordID, projectHost: projectHost, projectName: projectName, goal: goal, description: description, location: location,startTime: startTime, endTime: endTime, participantList: participantList, hostId: hostId, isFinish: isFinish, startDate: startDate, endDate: endDate, projectID: projectID)
    }
}

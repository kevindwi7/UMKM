//
//  ProjectViewModel.swift
//  UMKM
//
//  Created by Kevin  Dwi on 24/08/22.
//

import Foundation
import CloudKit

struct ProjectViewModel: Hashable, Identifiable {
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(id.hashValue)
    }

    static func == (lhs: ProjectViewModel, rhs: ProjectViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    let project: Project
    
    var id: CKRecord.ID? {
        project.id
    }
    
    var projectHost: String {
        project.projectHost
    }
    
    var projectName: String {
        project.projectName
    }
    
    var goal: String{
        project.goal
    }
    
    var participant: Int   {
        project.participant
    }
    var location: String {
        project.location
    }
    
    var startTime: Date {
        project.startTime
    }
    
    var endTime: Date {
        project.endTime
    }
    
    var description: String {
        project.description
    }
    
    var participantList: [String] {
        project.participantList
    }
    
    var hostId: String {
        project.hostiD
    }
    
    var isFinish: Int {
        project.isFinish
    }
    
    var startDate: Date {
        project.startDate
    }
    
    var endDate: Date {
        project.endDate
    }
}


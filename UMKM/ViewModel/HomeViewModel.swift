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
}

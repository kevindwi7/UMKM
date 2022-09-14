//
//  TaskCountViewModel.swift
//  UMKM
//
//  Created by Trevincen Tambunan on 14/09/22.
//

import Foundation
import CloudKit

final class TaskCountViewModel:ObservableObject{
    private var database: CKDatabase
    private var container: CKContainer
    
    @Published var takenTasks:Int = 0
    
    init(container: CKContainer) {
        self.container = container
        self.database = self.container.publicCloudDatabase
        
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
                                    self.takenTasks+=1
                                }
                                
                            }
                            //                            print(returnedRooms)
                        case .failure(let error):
                            print(error)
                        }
                    }
                print("Task")
                DispatchQueue.main.async {
//                    self.tasks = returnedTasks.map(TaskViewModel.init)
                    self.objectWillChange.send()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

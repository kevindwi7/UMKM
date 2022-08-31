//
//  DetailProjectTaskCard.swift
//  UMKM
//
//  Created by Kevin  Dwi on 24/08/22.
//

import SwiftUI
import CloudKit

struct DetailProjectTaskCard: View {
    @StateObject var vm:HomeViewModel
    @Binding var test: ProjectViewModel
    @Binding var task: TaskViewModel
    @State var isLoading = false
    let userID = UserDefaults.standard.object(forKey: "userID") as? String
    let firstName = UserDefaults.standard.object(forKey: "firstName") as? String
    let lastName = UserDefaults.standard.object(forKey: "lastName") as? String
    var body: some View {
        LoadingView(isShowing: $vm.isLoading){
            ZStack{
                Color.primaryGray
                ScrollView{
                    
                    Color.primaryGray
                    VStack(alignment:.leading,spacing: 10){
                        
                        ForEach ($vm.tasks, id: \.id) { $project in
                            HStack{
                                Text(task.taskName).font(.system(size: 12, weight: .regular, design: .default))
                                Spacer()
                                
                                Button {
                                    //handle assign to me
                                    vm.updateTaskParticipant(task: task, user: "\(firstName ?? "") \(lastName ?? "")", command: "join")
                                    print("Test")
                                    
                                } label: {
                                    if task.user.isEmpty{
                                        Text("Asign to Me").font(.system(size: 12, weight: .regular, design: .default))
                                    }else{
                                        Text(task.user).font(.system(size: 12, weight: .regular, design: .default))
                                    }
                                   
                                }
                                .frame(width: 103,height: 25)
                                .foregroundColor(.white)
                                .background(task.user.isEmpty ? .blue : .gray)
                                .cornerRadius(8)
                                .disabled(!task.user.isEmpty)
                                
                                
                            }
                            //                                DetailTaskCard(vm: HomeViewModel(container: CKContainer.default()), test: $test, task: $task)
                            
                        }
                        
                        //                        ForEach($vm.projects, id: \.id){ $testss in
                        //                            ForEach ($vm.taskse, id: \.id) { $tests in
                        //                                if ( testss.projectHost == tests.projectId){
                        //                                    DetailTaskCard(test: $test, task: $tests)
                        //                                }
                        //
                        //                            }
                        //                        }
                        //
                        //                        ForEach(0...15, id: \.self){ project in
                        //                            HStack{
                        //                                Text("Sapu Lantai").font(.system(size: 12, weight: .regular, design: .default))
                        //                                Spacer()
                        //
                        //                                Button {
                        //                                    //handle assign to me
                        //                                    print("Test")
                        //
                        //                                } label: {
                        //                                    Text("Asign to Me").font(.system(size: 12, weight: .regular, design: .default))
                        //                                }
                        //                                .frame(width: 103,height: 25)
                        //                                .foregroundColor(.white)
                        //                                .background(test.participantList.contains(userID!) ? .blue : .gray)
                        //                                .cornerRadius(8)
                        //                                .disabled(!test.participantList.contains(userID!))
                        //
                        //
                        //                            }
                        //                        }
                    }
                    .padding()
                    .navigationTitle("Detail Tugas")
                    
                    .frame(width: UIScreen.main.bounds.width/1.2, alignment:.leading)
                    .background(.white)
                    .cornerRadius(16)
                    
                    
                    
                    
                }.onAppear{
                    vm.fetchTask()
                }   .onReceive(vm.objectWillChange) { _ in
                    vm.fetchTask()
                }
            }
        }
        
        
        
        
        
    }
}

//struct DetailProjectTaskCard_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailProjectTaskCard(isProjectJoined: .constant(false))
//    }
//}


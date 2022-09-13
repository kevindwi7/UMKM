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
    @StateObject var mvm:MainViewModel
    @Binding var project: ProjectViewModel
    @Binding var task: [TaskViewModel]
    @State var isLoading = false
    @State var showingSheet = false
    @State var tasks2:TaskViewModel = TaskViewModel(task: Task(projectId: "asdasd", taskName: "asdsad", user: "asdasd", isFinish: true, registerUser: ["dsds"], registerUserID: ["dsds"], userID: "ndsjds", projectName: "asd"))
    @State var tasks: String = ""
    @State var isPM = true

    
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
                        ForEach($task, id: \.id){ $task in
                            HStack{
                                Text(task.taskName).font(.system(size: 14, weight: .regular, design: .default))
                                    .accessibilityLabel(task.taskName) //need to further update - vp
                                Spacer()
                                
                                Button {
                                    print(task.taskName)
                                    print(task)
                                    tasks2 = task
                                    //handle assign to me
                                    //                                    vm.updateTaskParticipant(task: task, user: "\(firstName ?? "") \(lastName ?? "")", command: "join")
                                    //                                    task = "Kevin Dwi"
                                    if(project.hostId == userID){
                                        self.showingSheet.toggle()
                                    }else{
                                        vm.updateTaskRegisterUser(task: task, user: firstName ?? "", userRegisterID: userID!, userID: "", command: "join")
                                    }
                                    
                                } label: {
                                    if (tasks.isEmpty) {
//                                        if (task.registerUserID.contains(userID!)){
//                                            Text("Sudah Daftar").font(.system(size: 14, weight: .regular, design: .default)).disabled(true)
//                                        }
                                        if(project.hostId == userID){
                                            Text("Pilih Anggota").font(.system(size: 14, weight: .regular, design: .default)).accessibilityLabel("tombol ambil tugas")
                                        }else{
                                            Text("Daftar").font(.system(size: 14, weight: .regular, design: .default))
                                        }
                                     
                                    }else{
                                        Text(tasks).font(.system(size: 14, weight: .regular, design: .default))
                                    }
                                    
                                }
                                .frame(width: 103,height: 25)
                                .foregroundColor(.white)
                                .background( !task.registerUserID.contains(userID!) ? .blue : .gray)
                                .cornerRadius(8)
//                                .disabled( task.registerUserID.contains(userID!))
                                
                                
                                
                            }
                        }
                    
                    }
                    .sheet(isPresented: $showingSheet) {
//                                    print($task)
                        AnggotaSheetView(vm: HomeViewModel(container: CKContainer.default()), tasks: self.$tasks2, projects: $project)
                    }
                    .padding()
                    .navigationTitle("Detail Tugas")
                    
                    .frame(width: UIScreen.main.bounds.width/1.2, alignment:.leading)
                    .background(.white)
                    .cornerRadius(16)
                    
                    
                    
                    
                }
//                                .onAppear{
//                                    vm.fetchTask()
//                                }   .onReceive(vm.objectWillChange) { _ in
//                                    vm.fetchTask()
//                                }
            }
        }
        
        
        
        
        
    }
}

//struct DetailProjectTaskCard_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailProjectTaskCard(isProjectJoined: .constant(false))
//    }
//}


//
//  DetailProjectView.swift
//  UMKM
//
//  Created by Kevin  Dwi on 24/08/22.
//

import SwiftUI
import CloudKit

struct DetailProjectView: View {
    
    @State var isProjectJoined = false
    @StateObject var vm: HomeViewModel
    @State var isActive = false
    @Binding var project: ProjectViewModel
//    @Binding var task: TaskViewModel
    @State var isLoading = false
    @State var isPresented: Bool = false
    
    let userID = UserDefaults.standard.object(forKey: "userID") as? String
    
    var body: some View {
            LoadingView(isShowing: $vm.isLoading){
                ZStack{
                    Color.primaryGray
                    ScrollView{
                            VStack(alignment:.leading, spacing: 10){
                                Text(project.projectName).font(.system(size: 25, weight: .bold, design: .default))
                                    .lineLimit(2)
                                    .multilineTextAlignment(.leading)
                                    .frame(width: UIScreen.main.bounds.width,alignment: .leading)
                                    .padding(.horizontal)
                                    .accessibilityLabel("proyek \(project.projectName)")
                                
                                .background(.white)
                                
                                DetailProjectCardView(project: $project).padding(.leading)
                                
                                DetailProjecrCard2View(project2: $project).padding(.leading)
                                
                                DetailProjectCard3View( project3: $project).padding(.leading)
                                
                                //                        if (project.participantList.contains(userID!)){
                                //                            DetailProjectTaskCard(test: $project)
                                //                        }else{
                                //                            Button {
                                //                                //handle join project
                                //                                self.isPresented = true
                                //
                                //                            } label: {
                                //                                Text("Join Project").foregroundColor(.white)
                                //                            }
                                //                            .alert(isPresented: $isPresented){
                                //                                Alert(
                                //                                    title: Text("Konfirmasi Project"),
                                //                                    message: Text("Apakah anda yakin bergabung ke project \(project.projectName)?"),
                                //                                    primaryButton: .default(Text("Gabung Projek"), action: {
                                //                                        vm.updateProjectMember(project: project, participantID: userID!, command: "join")
                                //                                        isLoading = true
                                //                                        isProjectJoined.toggle()
                                //                                    }),
                                //                                    secondaryButton: .destructive(Text("Batal"), action: { // 1
                                //
                                //
                                //                                    })
                                //                                )
                                //                            }
                                //                            .frame(width: UIScreen.main.bounds.width/1.2,height: 38)
                                //                            .background(.blue)
                                //                            .cornerRadius(12)
                                //
                                //                            DetailProjectTaskCard(test: $project)
                                //                        }
                            }
//                            .padding()
                        
                    }
//                    .navigationTitle(project.projectName).navigationBarTitleDisplayMode(.large)
                }
                .onReceive(vm.objectWillChange) {_ in
                    vm.fetchTask()
                    vm.fetchProject()
                }
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        if(project.hostId == userID) {
                            Button(action: {
                                vm.deleteProject(project: project)
                                isLoading = true
                            }){
                                Image(systemName: "trash")
                            }
                            .accessibilityLabel("Hapus \(project.projectName)")
                        }
                    }
                }
                
                
            }
        
        
        
        
        
        
    }
}

//struct DetailProjectView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailProjectView()
//    }
//}


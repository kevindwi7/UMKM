//
//  DetailProjectView.swift
//  UMKM
//
//  Created by Kevin  Dwi on 24/08/22.
//

import SwiftUI

struct DetailProjectView: View {
    
    @State var isProjectJoined = false
    @StateObject var vm: HomeViewModel
    @State var isActive = false
    @Binding var project: ProjectViewModel
    @State var isLoading = false
    @State var isPresented: Bool = false
    
    let userID = UserDefaults.standard.object(forKey: "userID") as? String
    
    var body: some View {
        LoadingView(isShowing: $vm.isLoading){
            ScrollView{
                ZStack{
                    Color.primaryGray
                    VStack(alignment:.leading, spacing: 28){
                        Text(project.projectName).font(.system(size: 25, weight: .bold, design: .default))
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 20)
                            .frame(width: 200, height: 60)
                        
                        DetailProjectCardView(project: $project)
                        
                        if (project.participantList.contains(userID!)){
                            DetailProjectTaskCard(test: $project)
                        }else{
                            Button {
                                //handle join project
                                self.isPresented = true
                                
                            } label: {
                                Text("Join Project").foregroundColor(.white)
                            }
                            .alert(isPresented: $isPresented){
                                Alert(
                                    title: Text("Konfirmasi Project"),
                                    message: Text("Apakah anda yakin bergabung ke project \(project.projectName)?"),
                                    primaryButton: .default(Text("Gabung Projek"), action: {
                                        vm.updateProjectMember(project: project, participantID: userID!, command: "join")
                                        isLoading = true
                                        isProjectJoined.toggle()
                                    }),
                                    secondaryButton: .destructive(Text("Batal"), action: { // 1
                                        
                                        
                                    })
                                )
                            }
                            .frame(width: UIScreen.main.bounds.width/1.2,height: 38)
                            .background(.blue)
                            .cornerRadius(12)
                            
                            DetailProjectTaskCard(test: $project)
                        }
                    }
                    .padding()
                }.toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        if(project.hostId == userID) {
                            Button(action: {
                                vm.deleteRoom(project: project)
                                isLoading = true
                            }){
                                Image(systemName: "trash")
                            }
                        }
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


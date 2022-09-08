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
    
//    let coloredAppearance = UINavigationBarAppearance()
    
    
  
//    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithDefaultBackground()
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
//
//        let standard = UINavigationBarAppearance()
//
//        standard.configureWithOpaqueBackground()
//
//        standard.backgroundColor = .systemPink
//        standard.titlePositionAdjustment = UIOffset(horizontal: -30, vertical: 0)
//        standard.titleTextAttributes = [.foregroundColor: UIColor.white]
//
//        let button = UIBarButtonItemAppearance(style: .plain)
//        button.normal.titleTextAttributes = [.foregroundColor: UIColor.systemYellow]
//        standard.buttonAppearance = button
//
//        let done = UIBarButtonItemAppearance(style: .done)
//        done.normal.titleTextAttributes = [.foregroundColor: UIColor.systemGreen]
//        standard.doneButtonAppearance = done
//
//        UINavigationBar.appearance().standardAppearance = standard
//
//        return false
//    }
    
    var body: some View {
            LoadingView(isShowing: $vm.isLoading){
                ZStack{
                    Color(UIColor.systemGray6)
                    ScrollView{
//                            VStack(alignment:.leading, spacing: 10){
//                                Text(project.projectName).font(.system(size: 25, weight: .bold, design: .default))
//                                    .lineLimit(2)
//                                    .multilineTextAlignment(.leading)
//                                    .frame(width: UIScreen.main.bounds.width,alignment: .leading)
//                                    .padding(.horizontal)
//                                    .accessibilityLabel("proyek \(project.projectName)")
//
//                                .background(.white)
                                
                        DetailProjectCardView(project: $project).padding(.top)
                                
                                DetailProjecrCard2View(project2: $project)
                                
                                DetailProjectCard3View( project3: $project)
                        
                                DetailProjectCard4View(project3: $project)
                        
//                                DetailProjectCard4View(project3: $projectParticipant).padding(.leading)
                                
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
                    .navigationTitle(project.projectName).navigationBarTitleDisplayMode(.inline)
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


//struct DetailProjectView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailProjectView(vm: self.vm)
//
//    }
//}


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
    @StateObject var mvm: MainViewModel
    @State var isActive = false
    @Binding var project: ProjectViewModel
    @Binding var tasks:[TaskViewModel]

    @State var isLoading = false
    @State var isPresented: Bool = false
    
    let userID = UserDefaults.standard.object(forKey: "userID") as? String
    
    var body: some View {
        LoadingView(isShowing: $vm.isLoading) {
            LoadingView(isShowing: $mvm.isLoading){
                ZStack{
                    Color(UIColor.systemGray6)
                    ScrollView{
                     
                        DetailProjectCardView(project: $project).padding(.top)
                        
                        DetailProjecrCard2View(project2: $project)
                        
                        DetailProjectCard3View(hm: HomeViewModel(container: CKContainer.default()), mvm: MainViewModel(container: CKContainer.default()), project3: $project, task: $mvm.tasks)
                    
//                        DetailProjectCard4Views(vm: MainViewModel(container: CKContainer.default()), project: $project, task: $mvm.tasks)
                        Spacer()
                        Button(action: {
                            //            self.isActive = !self.isActive
                            withAnimation(.easeInOut){self.isActive = !self.isActive}
                        }){
                            VStack(alignment:.leading,spacing: 15){
                                HStack{
                                    VStack(alignment:.leading, spacing: 6){
                                        Text("Anggota")
                                            .font(.system(.footnote, design: .rounded)).bold()
                                            .scaledFont(name: "", size: 14)
                                            .minimumScaleFactor(0.01)
                                            .lineLimit(1)
                                            .foregroundColor(.black)
                                        Text("\(project.participantListName.count-1) Orang")
                                            .font(.system(.caption, design: .rounded))
                                            .scaledFont(name: "", size: 12)
                                            .minimumScaleFactor(0.01)
                                            .lineLimit(1)
                                            .foregroundColor(.black)
                                            .accessibilityLabel("Jumlah anggota \(project.participantList.count) orang")
                                    }
                                    Spacer()
                                    Image(systemName: self.isActive == true ? "chevron.down" : "chevron.up")
                                        .font(.system(.headline, design: .rounded).bold())
                                        .accessibilityHidden(true)
                                }

                            }
                            .padding()
                            .frame(width: UIScreen.main.bounds.width/1.1, alignment:.leading)
                            .background(.white)
                            .cornerRadius(16)
                        }

                //   Form{
                //       Section{
                        ForEach ($mvm.takenTasks, id: \.self){ $task in
                //            VStack(alignment:.leading, spacing: 15){
                                HStack(alignment:.top, spacing: 15){
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40.8, height: 40.8)
                                        .foregroundColor(.black)
                                        .accessibilityLabel("foto \(task.user)") // need to further update dummy - vp
                                    VStack(alignment:.leading){
                                        Text(task.user) // need to further update dummy - vp
                                            .font(.system(.body, design: .rounded)).bold()
                                            .minimumScaleFactor(0.01)
                                            .lineLimit(1)
                                            .foregroundColor(.black)
                                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))

                                            .accessibilityLabel("\(task.user)")
                                        Text(task.taskName) // need to further update dummy - vp

                                            .accessibilityLabel("\(task.taskName)") // need to further update dummy - vp

                                        //Tugasnya
                //                        Text("\(project3.tasks.count)")
                //                        ForEach ($project3.tasks, id: \.self){ $task in
                //                            Text("Hellow") // need to further update dummy - vp
                //                                .font(.system(.caption, design: .rounded))
                //                        }
                                       
                                    }
                                }.padding()
                                    .frame(width: UIScreen.main.bounds.width/1.1, alignment:.leading)
                                    .background(.white)
                                    .cornerRadius(16)
                        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: self.isActive ? 0 : .none)
                            .clipped()
                        //                        .animation(.easeOut)
                        //                        .transition(.slide)
                        Button {
                            mvm.finishProject(project: project, isFinish: true)
                            print("finish")
                //            self.isActive.toggle()
                        }
                    label: {
                        Text("Selesai Proyek").foregroundColor(.white)
                            .font(.system(.caption, design: .rounded)).bold()
                            .frame(width: UIScreen.main.bounds.width/1.1,height: 38)
                            .background(.blue)
                            .cornerRadius(12)
                            .padding()
                    }

                    }
                }
                .navigationTitle(project.projectName).navigationBarTitleDisplayMode(.inline)
            }.onAppear{
//                print(self.project)
                mvm.tasks = []
                mvm.fetchTask(project: project)
                mvm.fetchTakenTasks(project: self.project)
            }
            
            .onReceive(vm.objectWillChange ) {_ in
                vm.fetchProject()
                
            }
            .onReceive(mvm.objectWillChange){_ in
                mvm.fetchTask(project: project)
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
//        DetailProjectView(vm: self.vm)
//
//    }
//}


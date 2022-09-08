//
//  HomeView.swift
//  UMKM
//
//  Created by Kevin  Dwi on 24/08/22.
//

import SwiftUI
import CloudKit

struct HomeView: View {
    @StateObject var vm:HomeViewModel
    @StateObject var mvm:MainViewModel
    //    @State var tvm:TaskViewModel
    
    @State var isActive = false
    @State var isFirstTimeActive = false
    @State var isListRoomView = false
    
    @State var usersID = UserDefaults.standard.object(forKey: "userID") as? String
    
    init(vm: HomeViewModel, mvm: MainViewModel) {
        _vm = StateObject(wrappedValue: vm)
        _mvm = StateObject(wrappedValue: mvm)
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                Color(UIColor.systemGray6)
                ScrollView(.vertical){
                    VStack(alignment: .leading){
                        ForEach($vm.projects, id: \.id){ $project in
                            //                            ForEach ($vm.tasks, id: \.id) { $taskHome in
                            
                            ProjectCardView(vm: self.vm, project: $project)
                            
                            
                            //                            }
                            
                        }.padding(.vertical, 6)
                    }.padding()
                    
                }
                //            .frame(width: UIScreen.main.bounds.width)
                
                .navigationTitle("Proyek")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button {
                        self.isActive = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }.sheet(isPresented: $isActive) {
                        CreateProjectView( vm: MainViewModel(container: CKContainer.default()), isActive: self.$isActive)
                    }.accessibilityLabel("Tambah Proyek")
                }
                .onAppear {
                    //                vm.fetchUserID()
                    vm.fetchProject()
                    mvm.fetchUserProfile()
//                    mvm.fetchUserID()
                    //vm.fetchTask()
                }
                .onReceive(vm.objectWillChange) { _ in
                    vm.fetchProject()
                    //vm.fetchTask()
                }
                //                .background(NavigationLink(destination: CreateProjectView(), isActive: $isActive, label: {
                //                    EmptyView()
                //                })
                //                )
            }
            
            .sheet(isPresented: $isFirstTimeActive){
                OnboardingView()
   
            }
          
            
        }.navigationViewStyle(.stack)
    }
}


//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}

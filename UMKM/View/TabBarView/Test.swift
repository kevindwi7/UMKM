////
////  Test.swift
////  UMKM
////
////  Created by Kevin  Dwi on 12/09/22.
////
//
//import SwiftUI
//import CloudKit
//
//struct Test: View {
//    @StateObject var vm:HomeViewModel
//    @StateObject var mvm:MainViewModel
//    //    @State var tvm:TaskViewModel
//    
//    @State var isActive = false
//    @State var isFirstTimeActive = false
//    @State var isListRoomView = false
//    
//    let userID = UserDefaults.standard.object(forKey: "userID") as? String
//    @State var isFirstTime = UserDefaults.standard.object(forKey: "isFirstTime") as? Bool ?? true
//    
//    init(vm: HomeViewModel, mvm: MainViewModel) {
//        _vm = StateObject(wrappedValue: vm)
//        _mvm = StateObject(wrappedValue: mvm)
//    }
//    var body: some View {
//        NavigationView{
//            ZStack{
//                Color(UIColor.systemGray6)
//                ScrollView(.vertical){
//                    VStack(alignment:.leading){
//                        ForEach ($vm.users, id: \.id){ $userss in
//                            ForEach($mvm.userFirstTimes, id: \.id){ $firstTimess in
//                                ForEach($vm.projects, id: \.id){ $project in
//                                    if (userID! == firstTimess.userID && firstTimess.isFirstTime == false){
//                                        ProjectCardView(vm: self.vm, mvm: self.mvm, project: $project)
//                                        
//                                    }else  if (userID! == firstTimess.userID && firstTimess.isFirstTime == true){
//                                        OnboardingView(vm: MainViewModel(container: CKContainer.default()), hm: self.hm, updateUser: $firstTimess, isActive: $isActive)
//                                    }
//                                    
//                                }
//                            }
//                        }
//                    }
//                }     .onAppear {
//                    //                vm.fetchUserID()
//                    vm.fetchProject()
//                    //                    mvm.fetchUserProfile()
//                    //                    mvm.fetchUserID()
//                    //vm.fetchTask()
//                }
//                .onReceive(vm.objectWillChange) { _ in
//                    vm.fetchProject()
//                    //vm.fetchTask()
//                }
//            }
//        }
//    }
//}
//
////struct Test_Previews: PreviewProvider {
////    static var previews: some View {
////        Test()
////    }
////}

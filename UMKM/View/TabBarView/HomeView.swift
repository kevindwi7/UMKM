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
    @StateObject var nvm:notificationViewModel
    
    @State var isActive = false
    @State var isFirstTimeActive = false
    @State var isListRoomView = false
    
    @State var usersID = UserDefaults.standard.object(forKey: "userID") as? String
    @State var isFirstTime = UserDefaults.standard.object(forKey: "isFirstTime") as? Bool ?? true
    
    init(vm: HomeViewModel, mvm: MainViewModel, nvm:notificationViewModel) {
        _vm = StateObject(wrappedValue: vm)
        _mvm = StateObject(wrappedValue: mvm)
        _nvm = StateObject(wrappedValue: nvm)
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                Color(UIColor.systemGray6)
                ScrollView(.vertical){
                    VStack(alignment: .leading){
                        ForEach($vm.projects, id: \.id){ $project in
            
                            ProjectCardView(vm: self.vm, mvm: self.mvm, project: $project,task: $mvm.tasks)
                            
                            //                            ForEach ($vm.tasks, id: \.id) { $taskHome in
                            
                          
                            
                            
                            //                            }
                            
                        }
                        .padding(.vertical, 6)
                    }
                    .padding()
                    
                }
                //            .frame(width: UIScreen.main.bounds.width)
                //
//                .navigationBarTitle(Text("Proyek").font(.largeTitle).bold(), displayMode: .inline).accentColor(Color(.label))
                //                                .uiFontMenuTitle(.title)
                
                //                .background(NavigationConfigurator { nc in
                //                                nc.navigationBar.barTintColor = .systemCyan
                //                                nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
                //                            })
                .toolbar {
                    Button {
                        self.isActive = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }.sheet(isPresented: $isActive) {
                        CreateProjectView( vm: MainViewModel(container: CKContainer.default()), isActive: self.$isActive)
                    }.foregroundColor(.white)
                        .accessibilityLabel("Tambah Proyek")
                }
                .onAppear {
                    vm.fetchProject()
                    vm.fetchAllUser()
                   
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
            .navigationTitle("Proyek")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isFirstTime ){
                ForEach($vm.users, id: \.id){ $userss in
                    if (userss.id?.recordName ?? "" == usersID){
//                        print(userss.id)
                        OnboardingView(vm: self.mvm, hm: self.vm, updateUser: $userss, isActive: $isFirstTime)
                            .onDisappear{
                                nvm.requestNotificationPermission { finish in
                                    nvm.subscribeToNotifications()
                                    print("Success")
                                }
                            }
                      
                    }
                }
            }
            //
            //
            //
            //
            
            
            
        }
        
        .ignoresSafeArea()
        
        .navigationViewStyle(.stack)
            .onAppear {
                let appearance = UINavigationBarAppearance()
                appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
                appearance.backgroundColor = UIColor(Color.cyan
                                                     //                            .opacity(0.2)
                )
                appearance.titleTextAttributes = [NSAttributedString.Key
                    .foregroundColor : UIColor.white]
                
                UINavigationBar.appearance().scrollEdgeAppearance = appearance
                
            }
        //                UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Georgia", size: 20)!]
        
        
        //            }
    }
}

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }
    
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(vm: HomeViewModel(container: CKContainer.default()))
//        
//    }
//}

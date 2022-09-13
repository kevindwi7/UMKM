//
//  AnggotaSheetView.swift
//  UMKM
//
//  Created by Trevincen Tambunan on 06/09/22.
//

import SwiftUI

struct AnggotaSheetView: View {
    @Binding var tasks: TaskViewModel
    @StateObject var vm:HomeViewModel
    @Binding var projects: ProjectViewModel
    @Binding var isActive:Bool
    
    @Environment(\.dismiss) var dismiss
    @State var test:Int = 5
    @State var status = ""
    
    let userID = UserDefaults.standard.object(forKey: "userID") as? String
    let firstName = UserDefaults.standard.object(forKey: "firstName") as? String
    let lastName = UserDefaults.standard.object(forKey: "lastName") as? String
    
    init(vm: HomeViewModel, tasks: Binding<TaskViewModel>, projects: Binding<ProjectViewModel>, isActive:Binding<Bool>) {
        _vm = StateObject(wrappedValue: vm)
        self._tasks = tasks
        self._projects = projects
        self._isActive = isActive
    }
    
    var body: some View {
        LoadingView(isShowing: $vm.isLoading){
            NavigationView {
                ZStack{
                    Color(UIColor.systemGray6)
                    ScrollView{
                        VStack(alignment:.leading) {
                            
                            Text("Pilih anggota untuk tugas")
                                .font(.system(size: 14, weight: .regular, design: .default))
                                .padding(.horizontal)
                            
                            Text(tasks.taskName).font(.system(size: 14, weight: .regular, design: .default)).padding(.horizontal)
                            
                            
                            ForEach(tasks.registerUser, id: \.self) { items in
                                VStack {
                                    HStack {
                                        Text(items.self).font(.system(size: 14, weight: .medium, design: .rounded))
                                        Spacer()
                                        Button(action: {
                                            print(userID!)
                                            print("\(firstName ?? "") \(lastName ?? "")")
                                            vm.updateProjectMember(project: projects, task: tasks, participantID: userID!, participantName:  "\(firstName ?? "") \(lastName ?? "")", userID: userID!, userName: "\(firstName ?? "") \(lastName ?? "")", userRegister: "\(firstName ?? "") \(lastName ?? "")", userRegisterID: userID!){
                                                self.isActive = true
                                            }
//                                            print(tasks)
                                        }, label: {
                                            Image(systemName: "person.fill.checkmark").opacity(0.5)
                                        })
                                        
                                        Button(action: {
                                            print("deecline")
                                           print(firstName!)
                                            vm.deleteTaskRegisterUser(task: tasks, userRegister:  "\(firstName ?? "") \(lastName ?? "")", userRegisterID: userID!)
                                            print("\(firstName ?? "") \(lastName ?? "")")
                                        }, label: {
                                            Image(systemName: "person.fill.xmark").opacity(0.5)
                                        })
                                        
                                        
                                    }
                                }
                                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                                    .frame(width: UIScreen.main.bounds.width/1.1, alignment:.leading)
                                    .background(.white)
                                    .cornerRadius(15)
//                                    .minimumScaleFactor(0.01)
//                                    .padding(.top, 16)
                            }
                            .padding(.vertical,0)
                            .cornerRadius(8)
                            .padding()
//                            ForEach($vm.users, id: \.id){ $userss in
//                                ForEach(tasks.registerUserID, id: \.self) { items in
//                                    if(userss.id!.recordName == items.self){
//                                        VStack {
//                                            HStack {
//                                                Text("\(userss.firstName) \(userss.lastName)").font(.system(size: 14, weight: .medium, design: .rounded))
//                                                Spacer()
//                                                Button(action: {
//                                                    print("accept")
//                                                    vm.updateProjectMember(project: projects, task: tasks, participantID: userss.id!.recordName, participantName:  "\(userss.firstName) \(userss.lastName)", userID: userss.id!.recordName, userName: "\(userss.firstName) \(userss.lastName)", userRegister: "\(userss.firstName) \(userss.lastName)", userRegisterID: userss.id!.recordName){
//                                                        self.isActive = true
//                                                    }
//                                                    //    //
//                                                    //                                                    print( "\(userss.firstName)\(userss.lastName)")
//                                                    //                                                    print( userss.id!.recordName)
//                                                    //                                                    print(tasks)
//                                                }, label: {
//                                                    Image(systemName: "person.fill.checkmark").opacity(0.5)
//                                                })
//
//                                                Button(action: {
//                                                    print(firstName!)
//                                                    vm.deleteTaskRegisterUser(task: tasks, userRegister:  "\(userss.firstName) \(userss.lastName)", userRegisterID: userss.id!.recordName)
//                                                    print("\(userss.firstName) \(userss.lastName)")
//                                                    //                                                vm.deleteCloudData(recordID: items)
//                                                }, label: {
//                                                    Image(systemName: "person.fill.xmark").opacity(0.5)
//                                                })
//
//
//                                            }
//                                        }
//                                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
//                                        .frame(width: UIScreen.main.bounds.width/1.1, alignment:.leading)
//                                        .background(.white)
//                                        .cornerRadius(15)
//                                        //                                    .minimumScaleFactor(0.01)
//                                        //                                    .padding(.top, 16)
//                                    }
//
//                                }
//                                .padding(.vertical,0)
//                                .cornerRadius(8)
//                                .padding()
//                            }
                            
//                            ForEach($vm.users, id: \.id){ $userss in
//                                ForEach(tasks.registerUserID, id: \.self) { items in
//                                    if(userss.id!.recordName == items.self){
//                                        VStack {
//                                            HStack {
//                                                Text("\(userss.firstName) \(userss.lastName)").font(.system(size: 14, weight: .medium, design: .rounded))
//                                                Spacer()
//                                                Button(action: {
//                                                    print("accept")
//                                                    vm.updateProjectMember(project: projects, task: tasks, participantID: userss.id!.recordName, participantName:  "\(userss.firstName) \(userss.lastName)", userID: userss.id!.recordName, userName: "\(userss.firstName) \(userss.lastName)", userRegister: "\(userss.firstName) \(userss.lastName)", userRegisterID: userss.id!.recordName){
//                                                        self.isActive = true
//                                                    }
//                                                    //    //
//                                                    //                                                    print( "\(userss.firstName)\(userss.lastName)")
//                                                    //                                                    print( userss.id!.recordName)
//                                                    //                                                    print(tasks)
//                                                }, label: {
//                                                    Image(systemName: "person.fill.checkmark").opacity(0.5)
//                                                })
//
//                                                Button(action: {
//                                                    print(firstName!)
//                                                    vm.deleteTaskRegisterUser(task: tasks, userRegister:  "\(userss.firstName) \(userss.lastName)", userRegisterID: userss.id!.recordName)
//                                                    print("\(userss.firstName) \(userss.lastName)")
//                                                    //                                                vm.deleteCloudData(recordID: items)
//                                                }, label: {
//                                                    Image(systemName: "person.fill.xmark").opacity(0.5)
//                                                })
//
//
//                                            }
//                                        }
//                                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
//                                        .frame(width: UIScreen.main.bounds.width/1.1, alignment:.leading)
//                                        .background(.white)
//                                        .cornerRadius(15)
//                                        //                                    .minimumScaleFactor(0.01)
//                                        //                                    .padding(.top, 16)
//                                    }
//
//                                }
//                                .padding(.vertical,0)
//                                .cornerRadius(8)
//                                .padding()
//                            }
                            

                        }.padding(.vertical, 16)
                        
                            .frame(width: UIScreen.main.bounds.width)
                            .navigationTitle("Anggota")
                            .toolbar(content: {
                                ToolbarItem(placement: .navigationBarLeading) {
                                    Button {
                                        dismiss()
                                        HapticManager.instance.notification(type: .warning)
                                    } label: {
                                        Text("Cancel").accessibilityLabel("Kembali")
                                    }
                                    
                                }
                                
                            }
                            )
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
                
                
            }
            .onAppear{
                vm.fetchProject()
//                vm.fetchAllUser()
                //                vm.fetchAcceptUser(registerUserName: tasks.registerUser)
                print(vm)
            }
            
            
        }
        
        
    }
}

//struct AnggotaSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        AnggotaSheetView()
//    }
//}

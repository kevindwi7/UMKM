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
    @Environment(\.dismiss) var dismiss
    @State var test:Int = 5
    @State var status = ""
    
    init(vm: HomeViewModel, tasks: Binding<TaskViewModel>, projects: Binding<ProjectViewModel>) {
        _vm = StateObject(wrappedValue: vm)
        self._tasks = tasks
        self._projects = projects
        
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
                                                print("accept")
                                                print(tasks)
                                            }, label: {
                                                Image(systemName: "person.fill.checkmark").opacity(0.5)
                                            })
                                            
                                            Button(action: {
                                                print("deecline")
                                                vm.deleteTaskRegisterUser(task: tasks, registerUser: items)
//                                                vm.deleteCloudData(recordID: items)
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
            }

        }
            
            
    }
}

//struct AnggotaSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        AnggotaSheetView()
//    }
//}

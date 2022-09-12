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
    @State var test:Int = 0
    
    init(vm: HomeViewModel, tasks: Binding<TaskViewModel>, projects: Binding<ProjectViewModel>) {
        _vm = StateObject(wrappedValue: vm)
        self._tasks = tasks
        self._projects = projects
        
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                Color(UIColor.systemGray6)
                ScrollView{
                    VStack(alignment:.leading) {
                     
                            Text("Pilih anggota untuk tugas")
                                .font(.system(size: 14, weight: .regular, design: .default))
                                .padding(.horizontal, 24)
                                .padding(.horizontal)
                        
                      
                        VStack{
                           
//                                ForEach($tasks, id: \.self){ $taskss in
                            Text(tasks.taskName).font(.system(size: 14, weight: .regular, design: .default)).padding(.horizontal)
                                       
                                    Spacer()
//                            }
                            
                                
                                ForEach(projects.participantList, id: \.self) { _ in
                                    VStack {
                                        HStack {
                                            Text("Kevin").font(.system(size: 14, weight: .medium, design: .rounded))
                                            Spacer()
                                            Button(action: {
                                                print("accept")
                                                print(tasks)
                                            }, label: {
                                                Image(systemName: "person.fill.checkmark").opacity(0.5)
                                            })
                                            
                                            Button(action: {
                                                print("deecline")
                                            }, label: {
                                                Image(systemName: "person.fill.xmark").opacity(0.5)
                                            })
                                            
                                            
                                        }
                                    }.padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                                        .frame(width: UIScreen.main.bounds.width/1.1, alignment:.leading)
                                        .background(.white)
                                        .cornerRadius(15)
                                        .minimumScaleFactor(0.01)
                                        .padding(.top, 16)
                                }
                                .cornerRadius(10)
                                .padding()
                                //                    .listStyle(.plain)
                            
                        }
                        
                        
                    }
                    
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
            vm.fetchAllUser()
        }
    }
}

//struct AnggotaSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        AnggotaSheetView()
//    }
//}

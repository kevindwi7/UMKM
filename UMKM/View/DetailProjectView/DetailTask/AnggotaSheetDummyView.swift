//
//  AnggotaSheetDummyView.swift
//  UMKM
//
//  Created by Kevin  Dwi on 14/09/22.
//

import SwiftUI

struct AnggotaSheetDummyView: View {
    
    @State var tasks2:[Task] = [Task(projectId: "asdsad", taskName: "asdasd", user: "asdsad", isFinish: false, registerUser: [""], registerUserID: [""], userID: "asd", projectName: "asdasd")]
    @Binding var pmButton:String
    @Binding var showingSheet:Bool
    @Binding var task:String
    
    var body: some View {
    
            NavigationView {
                ZStack{
                    Color(UIColor.systemGray6)
                    ScrollView{
                        VStack(alignment:.leading) {
                            
                            Text("Pilih anggota untuk tugas")
                                .font(.system(size: 14, weight: .regular, design: .default))
                                .padding(.horizontal)
                            
                            Text("SAPU").font(.system(size: 14, weight: .regular, design: .default)).padding(.horizontal)
                            
                            //                            ForEach($vm.users, id: \.id){ $userss in
                            //                                ForEach(tasks.registerUserID, id: \.self) { items in
                            //                                    if(userss.id!.recordName == items.self){
                            ForEach(tasks2, id: \.self){task in
                                VStack {
                                    HStack {
                                        Text(task.taskName).font(.system(size: 14, weight: .medium, design: .rounded))
                                        Spacer()
                                        Button(action: {
                                            print("accept")
                                            self.pmButton = "Selesai Pilih"
                                            self.task = "Keisi"
                                            self.showingSheet = false
                                            
                                      
                                            
                                        }, label: {
                                            Image(systemName: "person.fill.checkmark").opacity(0.5)
                                        })
                                        
                                        Button(action: {
//                                            print(firstName!)
                                            
                                            
                                        }, label: {
                                            Image(systemName: "person.fill.xmark").opacity(0.5)
                                        })
                                        
                                        
                                    }
                                }
                                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                                .frame(width: UIScreen.main.bounds.width/1.1, alignment:.leading)
                                .background(.white)
                                .cornerRadius(15)
                                
                                
                            } .padding(.vertical,0)
                                .cornerRadius(8)
                                .padding()
                            //                                    }
                            
                            //                                }
                            //
                            //                            }
                            
                            
                            
                        }.padding(.vertical, 16)
                        
                            .frame(width: UIScreen.main.bounds.width)
                            .navigationTitle("Anggota")
                            .toolbar(content: {
                                ToolbarItem(placement: .navigationBarLeading) {
                                    Button {
//                                        dismiss()
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
//            .onAppear{
//                vm.fetchProject()
//                vm.fetchAllUser()
//
//                print(vm)
//            }
            
            
        
    }
}

//struct AnggotaSheetDummyView_Previews: PreviewProvider {
//    static var previews: some View {
//        AnggotaSheetDummyView()
//    }
//}

//
//  TaskView.swift
//  UMKM
//
//  Created by Trevincen Tambunan on 26/08/22.
//

import SwiftUI

struct TaskView: View {
//    @StateObject private var vm: MainViewModel
    @State  var totalTask:Int = 1
    @State  var tasks = [""]
    @State private var isFinish: Bool = false
    @State var isLoading = false
    
    @Binding  var namaProjectTask: String
    @Binding  var tujuanProjectTask: String
    @Binding  var deskripsiProjectTask: String
    @Binding  var startDateTask: Date
    @Binding var endDateTask: Date
    @Binding  var startTimeTask: Date
    @Binding var endTimeTask: Date
    @Binding var lokasiProjectTask: String
    @Binding var projectID: String
    
    @StateObject private var vm: MainViewModel
    
    init(vm: MainViewModel, namaProjectTask: Binding<String>, tujuanProjectTask: Binding<String>, deskripsiProjectTask: Binding<String>, startDateTask: Binding<Date>, endDateTask: Binding<Date>, startTimeTask: Binding<Date>, endTimeTask: Binding<Date>, lokasiProjectTask: Binding<String>, projectID: Binding<String>) {
        _vm = StateObject(wrappedValue: vm)
        self._namaProjectTask = namaProjectTask
        self._tujuanProjectTask = tujuanProjectTask
        self._deskripsiProjectTask = deskripsiProjectTask
        self._startDateTask = startDateTask
        self._endDateTask = endDateTask
        self._startTimeTask = startTimeTask
        self._endTimeTask = endTimeTask
        self._lokasiProjectTask = lokasiProjectTask
        self._projectID = projectID
    }
    
   
    
    let userID = UserDefaults.standard.object(forKey: "userID") as? String
    let firstName = UserDefaults.standard.object(forKey: "firstName") as? String
    let lastName = UserDefaults.standard.object(forKey: "lastName") as? String
    
//    init() {
//        let navBarAppearance = UINavigationBar.appearance()
//        navBarAppearance.backgroundColor = .white
//        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
//        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
//    }
    
    var body: some View {
        LoadingView(isShowing: $vm.isLoading){
            ZStack {
                Color.primaryGray.ignoresSafeArea()
                VStack {
                    Spacer().frame(height:15)
                    ScrollView {
                        VStack{
                            Text("Tulis tugas apa saja yang di perlukan untuk menjalankan proyek komunitasmu").font(.system(size: 12, weight: .medium, design: .default))
                            ForEach(0...totalTask-1, id: \.self) { task in
                                TextField("Tugas \(task+1)", text: self.$tasks[task]).textFieldStyle(CustomTextFieldStyle())
                                    .frame(width: UIScreen.main.bounds.width/1.2,height: 50)
                            }
                            Button {
                                self.totalTask+=1
                                tasks.append("")
                            } label: {
                                Text("Tambah Tugas").foregroundColor(.white).font(.system(size: 12, weight: .medium, design: .default)).frame(width: UIScreen.main.bounds.width/1.2,height: 30)
                                    .background(.blue)
                                    .cornerRadius(12)
                                    .padding()
                            }
                            Spacer()
                        }.navigationTitle("Atur Tugas")
                        Spacer()
                    }.frame(width:UIScreen.main.bounds.width/1.2).padding().background(.white).cornerRadius(8)
                    Button {
                        //handle save project
                        vm.createProject(projectHost: "\(firstName ?? "")\(lastName ?? "")", projectName: namaProjectTask, location: lokasiProjectTask, startTime: startTimeTask, endTime: endTimeTask, participantList: [userID!], description: deskripsiProjectTask, goal: tujuanProjectTask, hostId: userID!, isFinish: isFinish, startDate: startDateTask, endDate: endDateTask, projectID: projectID)
                        
                        for task in tasks {
                            vm.createTask(projectId: projectID, taskName: task, user: "")
                                
                                
                        }
                            
//                        vm.createTask(projectId: projectID, taskName: "", user: "")
                            
                            
                            
//                            for task in tasks {
//                                print(task)
//                                vm.createTask(projectId: "", taskName: task, user: "")
//                            }
                            
//                            print(firstName)
//                            print(namaProjectTask)
//                            print(startTimeTask)
                            
    //                        for task in tasks {
    //                            print(task)
    //                        }
    //                        ForEach (0..<tasks.count, id: \.self) { item in
    //                            vm.createTask(projectId: "", taskName: self.tasks[item], user: "")
    //                        }
                            
                            
                        }
                     label: {
                        Text("Selesai").foregroundColor(.white).font(.system(size: 12, weight: .medium, design: .default)).frame(width: UIScreen.main.bounds.width/1.1,height: 38)
                            .background(.blue)
                            .cornerRadius(12)
                            .padding()
                    }
                }
            }
        }
       
    }
}

//struct TaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskView()
//    }
//}

public struct CustomTextFieldStyle : TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
        // set the inner Text Field Font
            .padding(10) // Set the inner Text Field Padding
        //Give it some style
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(Color.primary.opacity(0.2), lineWidth: 1))
    }
}

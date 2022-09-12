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
    
    @Binding var isActive:Bool
    @Binding  var namaProjectTask: String
    @Binding  var tujuanProjectTask: String
    @Binding  var deskripsiProjectTask: String
    @Binding  var startDateTask: Date
    @Binding var endDateTask: Date
    @Binding  var startTimeTask: Date
    @Binding var endTimeTask: Date
    @Binding var lokasiProjectTask: String
    @Binding var projectID: String
    @Binding var divisi: String
    
    @StateObject private var vm: MainViewModel
    
    init(vm: MainViewModel, namaProjectTask: Binding<String>, tujuanProjectTask: Binding<String>, deskripsiProjectTask: Binding<String>, startDateTask: Binding<Date>, endDateTask: Binding<Date>, startTimeTask: Binding<Date>, endTimeTask: Binding<Date>, lokasiProjectTask: Binding<String>, projectID: Binding<String>, isActive:Binding<Bool>, divisi:Binding<String>) {
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
        self._isActive = isActive
        self._divisi = divisi
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
//                    Spacer().frame(height:15)
                    Form {
//                        VStack{
//                            Text("Tulis tugas apa saja yang di perlukan untuk menjalankan proyek komunitasmu").font(.system(.subheadline, design: .rounded))
//                                .foregroundColor(.black)
//                                .accessibilityLabel("Tulis tugas apa saja yang di perlukan untuk menjalankan proyek komunitasmu")
                            ForEach(0...totalTask-1, id: \.self) { task in
                                TextField("Tugas \(task+1)", text: self.$tasks[task]).textFieldStyle(.plain)
//                                    .frame(width: UIScreen.main.bounds.width/1.2,height: 50)
                                    .foregroundColor(.black)
                            }
                        
                        Button(action: {
                            self.totalTask+=1
                            tasks.append("")
                        }){
                                    HStack(spacing: 6){
                                        Image(systemName:"plus.circle.fill")
                                            .font(.system(size: 14, weight: .medium, design: .default)).foregroundColor(.cyan)
                                                .accessibilityHidden(true)
                                        Text("Tambah Tugas")
                                            .font(.system(.footnote, design: .rounded))
                                            .scaledFont(name: "", size: 14)
                                            .minimumScaleFactor(0.01)
                                            .lineLimit(1)
                                            .foregroundColor(.black)
                                    }

                        }.accessibilityLabel("Tombol Tambah Tugas")

//                            Spacer()
//                        }
                        //
        
                    }
                    .navigationTitle("Atur Tugas")
//                    .frame(width:UIScreen.main.bounds.width/1.2).padding().background(.white).cornerRadius(8)
                    Button {
                        //handle save project
                        //                        self.isLoading = true
                        vm.createProject(projectHost: "\(firstName ?? "")\(lastName ?? "")", projectName: namaProjectTask, location: lokasiProjectTask, startTime: startTimeTask, endTime: endTimeTask, participantList: [userID!], description: deskripsiProjectTask, goal: tujuanProjectTask, hostId: userID!, isFinish: isFinish, startDate: startDateTask, endDate: endDateTask, projectID: projectID,participantListName: ["\(firstName ?? "")\(lastName ?? "")"], divisi: divisi){
                            self.isActive.toggle()
                        }
                        
                        for task in tasks {
                            vm.createTask(projectId: projectID, taskName: task, user: "", isFinish: false, registerUser: [""], registerUserID: [""])
                            
                            
                        }
                    }
                label: {
                    Text("Selesai").foregroundColor(.white).font(.system(size: 12, weight: .medium, design: .default)).frame(width: UIScreen.main.bounds.width/1.1,height: 38)
                        .background(.blue)
                        .cornerRadius(12)
                        .padding()
                }
                    
                }
            }
        }.frame(width: UIScreen.main.bounds.width/0.95)
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


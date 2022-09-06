//
//  CreateProjectView.swift
//  UMKM
//
//  Created by Kevin  Dwi on 24/08/22.
//

import SwiftUI
import CloudKit

struct CreateProjectView: View {
    @StateObject var vm: MainViewModel
    @Binding var isActive:Bool
    @State var namaProject:String = ""
    @State var tujuanProject:String = ""
    @State var deskripsiProject:String = ""
    @State var startDate:Date = Date()
    @State var endDate:Date = Date()
    @State var startTime:Date = Date()
    @State var endTime:Date = Date()
    @State var lokasiProject:String = ""
    @State var projectID: String = ""
    @State var action: Int? = 0
    
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color.primaryGray.ignoresSafeArea()
                ScrollView {
                    VStack(spacing:10){
                        VStack{
                            NavigationLink(destination:  TaskView(vm: MainViewModel(container: CKContainer.default()), namaProjectTask: $namaProject, tujuanProjectTask: $tujuanProject, deskripsiProjectTask: $deskripsiProject, startDateTask: $startDate, endDateTask: $endDate, startTimeTask: $startTime, endTimeTask: $endTime, lokasiProjectTask: $lokasiProject, projectID: $projectID, isActive: $isActive), tag: 1, selection: $action){
                                EmptyView()
                            }
                            HStack{
                                Text("Nama Proyek").font(.system(size: 14, weight: .medium, design: .default))
                                Spacer()
                                TextField("", text: $namaProject).frame(width:180)
                            }.accessibilityElement(children: .combine)
                                .accessibilityLabel("tulis nama proyek")
                            HStack {
                                Text("Tujuan").font(.system(size: 14, weight: .medium, design: .default))
                                Spacer()
                                TextField("", text: $tujuanProject).frame(width:180)
                            }.accessibilityElement(children: .combine)
                                .accessibilityLabel("tulis tujuan proyek")
                            HStack {
                                Text("Deskripsi").font(.system(size: 14, weight: .medium, design: .default))
                                Spacer()
                                TextEditor(text: $deskripsiProject)
                                    .frame(width:180 ,height:120)
                                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(.gray.opacity(0.2), lineWidth: 1))
                            }.accessibilityElement(children: .combine)
                                .accessibilityLabel("tulis deskripsi proyek")
                            HStack{
                                Text("Tanggal Mulai").font(.system(size: 14, weight: .medium, design: .default))
                                    .accessibilityHidden(true)
                                Spacer()
                                DatePicker("", selection: $startDate, displayedComponents: .date).labelsHidden()
                                    .frame(width: 130, height: 40, alignment: .center)
                            }.accessibilityElement(children: .combine)
                                .accessibilityLabel("Input tanggal mulai proyek")
                            HStack{
                                Text("Tanggal Selesai").font(.system(size: 14, weight: .medium, design: .default))
                                    .accessibilityHidden(true)
                                Spacer()
                                DatePicker("", selection: $endDate, displayedComponents: .date).labelsHidden()
                                    .frame(width: 130, height: 40, alignment: .center)
                            }.accessibilityElement(children: .combine)
                                .accessibilityLabel("Input tanggal selesai proyek")
                            HStack{
                                Text("Waktu").font(.system(size: 14, weight: .medium, design: .default))
                                    .accessibilityHidden(true)
                                Spacer()
                                DatePicker("", selection: $startTime, displayedComponents: .hourAndMinute).labelsHidden()
                                    .frame(width: UIScreen.main.bounds.width/3.7, height: 40, alignment: .center)
                                    .accessibilityLabel("Input waktu mulai proyek")
                                Text("-")
                                DatePicker("", selection: $endTime, displayedComponents: .hourAndMinute).labelsHidden()
                                    .frame(width: UIScreen.main.bounds.width/3.7, height: 40, alignment: .center)
                            }.accessibilityElement(children: .combine)
                                .accessibilityLabel("Waktu kegiatan")
                            HStack{
                                Text("Lokasi").font(.system(size: 14, weight: .medium, design: .default))
                                    .accessibilityHidden(true)
                                Spacer()
                                TextField("", text: $lokasiProject).frame(width:180)
                            }.accessibilityElement(children: .combine)
                            .accessibilityLabel("Tulis lokasi proyek")
                        }.frame(width: UIScreen.main.bounds.width/1.2).padding().background(.white).cornerRadius(8)
                        Button(action: {
                            projectID = randomString(length: 10)
                            self.action = 1
                            
                        }, label: {
                            Text("Lanjut Bagi Tugas").foregroundColor(.white).font(.system(size: 12, weight: .medium, design: .default)).frame(width: UIScreen.main.bounds.width/1.2,height: 38) .accessibilityLabel("Tombol Lanjut Bagi Tugas")
                        }).frame(width: UIScreen.main.bounds.width/1.1,height: 38)
                            .background(.blue)
                            .cornerRadius(12)
                            .padding()
//                            Text("Lanjut Bagi Tugas").foregroundColor(.white).font(.system(size: 12, weight: .medium, design: .default)).frame(width: UIScreen.main.bounds.width/1.2,height: 38)
//
//                            .accessibilityLabel("Tombol Lanjut Bagi Tugas")
//                            .onTapGesture {
//                                HapticManager.instance.notification(type: .success)
//                            }
                        Spacer()
                    }
                    .padding()
                    .navigationTitle("Buat Proyek").navigationBarTitleDisplayMode(.inline)
                    .toolbar(content: {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                self.isActive.toggle()
                                HapticManager.instance.notification(type: .warning)
                            } label: {
                                HStack{
                                    Image(systemName: "chevron.left")
                                    Text("Proyek")
                                }.accessibilityLabel("Tombol kembali ke halaman proyek")
                            }
                            
                        }

                    }
                    )
                }
                
            }
            .textFieldStyle(.roundedBorder).frame(width: UIScreen.main.bounds.width/1.2)
        }
        
    }
    
}


//struct CreateProjectView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateProjectView(isActive: .constant(true))
//    }
//}

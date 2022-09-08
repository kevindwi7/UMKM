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
                Color(UIColor.systemGray6).ignoresSafeArea()
                ScrollView {
                    VStack(spacing:10){
                        VStack{
                            NavigationLink(destination:  TaskView(vm: MainViewModel(container: CKContainer.default()), namaProjectTask: $namaProject, tujuanProjectTask: $tujuanProject, deskripsiProjectTask: $deskripsiProject, startDateTask: $startDate, endDateTask: $endDate, startTimeTask: $startTime, endTimeTask: $endTime, lokasiProjectTask: $lokasiProject, projectID: $projectID, isActive: $isActive), tag: 1, selection: $action){
                                EmptyView()
                            }
//                            Form{
//
//                                    VStack{
//                                        Image(systemName: "circle.inset.filled")
//                                            .font(.system(.footnote, design: .rounded))
//                                            .scaledFont(name: "", size: 14)
//                                            .minimumScaleFactor(0.01)
//                                            .lineLimit(1)
//                                            .foregroundColor(.black)
//                                        Spacer()
//                                        TextField("", text: $namaProject)
//                                            .frame(width:180)
//                                    }.accessibilityElement(children: .combine)
//                                        .accessibilityLabel("tulis nama proyek")
//
//                            }
                            
                            //Nama Proyek
                            HStack{
                                Image(systemName: "circle.inset.filled").font(.system(size: 14, weight: .medium, design: .default)).foregroundColor(.cyan)
                                Spacer()
                                TextField("Nama proyek", text: $namaProject).foregroundColor(.black)
                            }.accessibilityElement(children: .combine)
                                .accessibilityLabel("tulis nama proyek")
                            
                            //Tujuan Proyek
                            HStack {
                                Image(systemName: "target").font(.system(size: 14, weight: .medium, design: .default)).foregroundColor(.cyan)
                                Spacer()
//                                TextField("Tujuan", text: $tujuanProject).foregroundColor(.black)
                                TextEditor(text: $tujuanProject)
                                    .frame(height:100)
                                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(.gray.opacity(0.2), lineWidth: 1))
                            }.accessibilityElement(children: .combine)
                                .accessibilityLabel("tulis tujuan proyek")
                            
                            //Lokasi
                            HStack {
                                Image(systemName: "mappin.and.ellipse").font(.system(size: 14, weight: .medium, design: .default)).foregroundColor(.cyan)
                                Spacer()
                                TextField("Lokasi", text: $lokasiProject)
//                                    .frame(width:180 ,height:120)
//                                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(.gray.opacity(0.2), lineWidth: 1))
                            }.accessibilityElement(children: .combine)
                                .accessibilityLabel("tulis lokasi proyek")
                            
                            //Divisi
                            HStack {
                                Image(systemName: "person.2.fill").font(.system(size: 10, weight: .medium, design: .default)).foregroundColor(.cyan)
                                Spacer()
                                TextField("Divisi", text: $tujuanProject).foregroundColor(.black) //need to chage to ...
//                                TextEditor(text: $tujuanProject)
//                                    .frame(width:180 ,height:120)
//                                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(.gray.opacity(0.2), lineWidth: 1))
                            }.accessibilityElement(children: .combine)
                                .accessibilityLabel("input divisi")
                            
                            //Deskripsi Proyek
                            HStack {
                                Image(systemName: "text.justify.left").font(.system(size: 14, weight: .medium, design: .default)).foregroundColor(.cyan)
                                Spacer()
                                TextEditor(text: $deskripsiProject)
                                    .frame(height:100)
                                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(.gray.opacity(0.2), lineWidth: 1))
                            }.accessibilityElement(children: .combine)
                                .accessibilityLabel("Tulis deskrisi proyek")
                            
                            //tanggal mulai
                            HStack{
                                Image(systemName: "calendar").font(.system(size: 14, weight: .medium, design: .default)).foregroundColor(.cyan)
                                Spacer()
                                DatePicker("Tanggal Mulai", selection: $startDate, displayedComponents: .date).foregroundColor(.gray)
//                                    .frame(width: 130, height: 40, alignment: .center)
                            }.accessibilityElement(children: .combine)
                                .accessibilityLabel("Input tanggal mulai proyek")
                            
                            //tanggal selesai
                            HStack{
                                Image(systemName: "calendar").font(.system(size: 14, weight: .medium, design: .default)).foregroundColor(.cyan)
                                    .accessibilityHidden(true)
                                Spacer()
                                DatePicker("Tanggal Selesai", selection: $endDate, displayedComponents: .date)
//                                    .frame(width: 130, height: 40, alignment: .center)
                                    .foregroundColor(.gray)
                            }.accessibilityElement(children: .combine)
                                .accessibilityLabel("Input tanggal selesai proyek")
                            
                            //waktu mulai
                            HStack{
                                Image(systemName: "clock").font(.system(size: 14, weight: .medium, design: .default)).foregroundColor(.cyan)
                                    .accessibilityHidden(true)
                                Spacer()
                                DatePicker("Waktu mulai", selection: $startTime, displayedComponents: .hourAndMinute).foregroundColor(.gray)
//                                    .frame(width: UIScreen.main.bounds.width/3.7, height: 40, alignment: .center)
                                .accessibilityLabel("Input waktu mulai proyek")
                                
                            }
                                
                            // waktu selesai
                            HStack{
                                Image(systemName: "clock").font(.system(size: 14, weight: .medium, design: .default)).foregroundColor(.cyan)
                                    .accessibilityHidden(true)
                                DatePicker("Waktu selesai", selection: $endTime, displayedComponents: .hourAndMinute)
                                    .foregroundColor(.gray)
//                                    .frame(width: UIScreen.main.bounds.width/3.7, height: 40, alignment: .center)
                            }.accessibilityElement(children: .combine)
                                .accessibilityLabel("Input waktu selesai proyek")
                            
                    
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

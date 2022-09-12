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
    //    @State var divisi:String = ""
    @State var startDate:Date = Date()
    @State var endDate:Date = Date()
    @State var startTime:Date = Date()
    @State var endTime:Date = Date()
    @State var lokasiProject:String = ""
    @State var undangAnggota:String = ""
    @State var projectID: String = ""
    @State var action: Int? = 0
    @State private var text = ""
    
    
    enum DivisiEnum: String, CaseIterable, Identifiable {
        case Humas, Sosmed, Seketariat, Lainya
        var id: Self { self }
    }
    
    @State private var divisi: DivisiEnum = .Humas
    
    
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
                //            ScrollView {
                VStack(){
                    VStack{
                        NavigationLink(destination:  TaskView(vm: MainViewModel(container: CKContainer.default()), namaProjectTask: $namaProject, tujuanProjectTask: $tujuanProject, deskripsiProjectTask: $deskripsiProject, startDateTask: $startDate, endDateTask: $endDate, startTimeTask: $startTime, endTimeTask: $endTime, lokasiProjectTask: $lokasiProject, projectID: $projectID, isActive: $isActive), tag: 1, selection: $action){
                            EmptyView()
                        }
                        
                        Form{
                            
//
                            //Nama Proyek
                            HStack{
                                Image(systemName: "circle.inset.filled").font(.system(size: 14, weight: .medium, design: .default)).foregroundColor(.cyan)
                                Spacer()
                                TextField("Nama proyek", text: $namaProject).foregroundColor(.black).textFieldStyle(.plain).font(.system(.subheadline, design: .rounded))
                            }.accessibilityElement(children: .combine)
                                .accessibilityLabel("tulis nama proyek")

                            //Tujuan Proyek
                            HStack (alignment: .top){
                                Image(systemName: "target").font(.system(size: 14, weight: .medium, design: .default)).foregroundColor(.cyan).padding(EdgeInsets(top: 7, leading: 0, bottom: 0, trailing: 0))
                                Spacer()
                                CustomTextEditor.init(placeholder: "Tujuan Proyek", text: $tujuanProject)
                                    .foregroundColor(.black)
                                    .font(.system(.subheadline, design: .rounded))
                                    .frame(height:80)
                            }.accessibilityElement(children: .combine)
                                .accessibilityLabel("tulis tujuan proyek")

                            //Lokasi
                            HStack {
                                Image(systemName: "mappin.and.ellipse").font(.system(size: 14, weight: .medium, design: .default)).foregroundColor(.cyan)
                                Spacer()
                                TextField("Lokasi", text: $lokasiProject).foregroundColor(.black)
                                    .font(.system(.subheadline, design: .rounded))
                            }.accessibilityElement(children: .combine)
                                .accessibilityLabel("tulis lokasi proyek")

                            //Divisi
                            HStack{
                                Image(systemName: "person.2.fill").font(.system(size: 10, weight: .medium, design: .default)).foregroundColor(.cyan)
                                Spacer()
                                Picker(selection: $divisi, label: Text("Divisi").foregroundColor(.black).font(.system(.subheadline, design: .rounded))) {
                                    ForEach(CreateProjectView.DivisiEnum.allCases) { flavor in
                                        Text(flavor.rawValue.capitalized)
                                    }.foregroundColor(.black)
                                }
                                
                                //                            Image(systemName: "chevron.right").foregroundColor(.cyan)
                                //                                                            .font(.system(.body, design: .rounded).bold())
                                //                                                            .accessibilityHidden(true)
                            }.accessibilityElement(children: .combine)
                                .accessibilityLabel("pilih divisi")
                            //


                            //need to chage to ...
                            //                                TextEditor(text: $tujuanProject)
                            //                                    .frame(width:180 ,height:120)
                            //                                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(.gray.opacity(0.2), lineWidth: 1))


                            //Deskripsi Proyek
                            HStack  (alignment: .top){
                                Image(systemName: "text.justify.left").font(.system(size: 14, weight: .medium, design: .default)).foregroundColor(.cyan).padding(EdgeInsets(top: 7, leading: 0, bottom: 0, trailing: 0))
                                Spacer()
                                CustomTextEditor.init(placeholder: "Deskripsi Proyek", text: $deskripsiProject)
                                    .foregroundColor(.black).font(.system(.subheadline, design: .rounded))
                                    .frame(height:80)
                                //                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(.gray.opacity(0.2), lineWidth: 1))
                            }.accessibilityElement(children: .combine)
                                .accessibilityLabel("Tulis deskripsi proyek")
                            
                            //tanggal mulai
                            HStack{
                                Image(systemName: "calendar").font(.system(size: 14, weight: .medium, design: .default)).foregroundColor(.cyan)
                                Spacer()
                                DatePicker("Tanggal Mulai", selection: $startDate, displayedComponents: .date).foregroundColor(.black).font(.system(.subheadline, design: .rounded))
                                    .minimumScaleFactor(0.01)
                                    .lineLimit(2)
                                //                                    .frame(width: 130, height: 40, alignment: .center)
                            }.accessibilityElement(children: .combine)
                                .accessibilityLabel("Pilih tanggal mulai proyek")

                            //tanggal selesai
                            HStack{
                                Image(systemName: "calendar").font(.system(size: 14, weight: .medium, design: .default)).foregroundColor(.cyan)
                                    .accessibilityHidden(true)
                                Spacer()
                                DatePicker("Tanggal Selesai", selection: $endDate, displayedComponents: .date).font(.system(.subheadline, design: .rounded))
                                    .minimumScaleFactor(0.001)
                                    .lineLimit(2)
                                //                                    .frame(width: 130, height: 40, alignment: .center)
                                    .foregroundColor(.black)
                            }.accessibilityElement(children: .combine)
                                .accessibilityLabel("Pilih tanggal selesai proyek")

                            //waktu mulai
                            HStack{
                                Image(systemName: "clock").font(.system(size: 14, weight: .medium, design: .default)).foregroundColor(.cyan)
                                    .accessibilityHidden(true)
                                Spacer()
                                DatePicker("Waktu mulai", selection: $startTime, displayedComponents: .hourAndMinute).foregroundColor(.black).font(.system(.subheadline, design: .rounded))
                                    .minimumScaleFactor(0.01)
                                    .lineLimit(2)
                                //                                    .frame(width: UIScreen.main.bounds.width/3.7, height: 40, alignment: .center)
                                    .accessibilityLabel("Pilih waktu mulai proyek")

                            }

                            // waktu selesai
                            HStack{
                                Image(systemName: "clock").font(.system(size: 14, weight: .medium, design: .default)).foregroundColor(.cyan)
                                    .accessibilityHidden(true)
                                DatePicker("Waktu selesai", selection: $endTime, displayedComponents: .hourAndMinute)
                                    .foregroundColor(.black).font(.system(.subheadline, design: .rounded))
                                    .minimumScaleFactor(0.01)
                                    .lineLimit(2)
                                //                                    .frame(width: UIScreen.main.bounds.width/3.7, height: 40, alignment: .center)
                            }.accessibilityElement(children: .combine)
                                .accessibilityLabel("Pilih waktu selesai proyek")
//
//
                            
                            
                            
                            
                        }
                        
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
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
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                projectID = randomString(length: 10)
                                self.action = 1
                            } label: {
                                HStack{
                                    Text("Lanjut")
                                    Image(systemName: "chevron.right")
                                }.accessibilityLabel("Tombol kembali ke halaman proyek")
                            }
                            
                        }
                        
                    }
                    )
                    //                }
                    
                }
                .textFieldStyle(.plain)
                .frame(width: UIScreen.main.bounds.width/0.86)
                
            }
        }
        
    }
}

//struct CreateProjectView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateProjectView(isActive: .constant(true))
//    }
//}
struct CustomTextEditor: View {
    
    let placeholder: String
    @Binding var text: String
    //    let internalPadding: CGFloat = 0
    
    
    var body: some View {
        ZStack(alignment: .topLeading){
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.gray.opacity(0.6))
                    .padding(EdgeInsets(top: 8, leading: 0, bottom: 5, trailing: 14))
                
            }
            TextEditor(text: $text)
            //                .padding(internalPadding)
        }
        
    }
}

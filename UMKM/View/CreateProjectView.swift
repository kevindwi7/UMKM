//
//  CreateProjectView.swift
//  UMKM
//
//  Created by Kevin  Dwi on 24/08/22.
//

import SwiftUI

struct CreateProjectView: View {
    @State var namaProject:String = ""
    @State var tujuanProject:String = ""
    @State var deskripsiProject:String = ""
    @State var startDate:Date = Date()
    @State var endDate:Date = Date()
    @State var startTime:Date = Date()
    @State var endTime:Date = Date()
    @State var lokasiProject:String = ""
    
    var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter
        }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color.primaryGray.ignoresSafeArea()
                VStack(spacing:10){
                    Spacer().frame(height:1)
                    VStack{
                        HStack{
                            Text("Nama Proyek").font(.system(size: 14, weight: .medium, design: .default))
                            Spacer()
                            TextField("", text: $namaProject).frame(width:180)
                        }
                        HStack {
                            Text("Tujuan").font(.system(size: 14, weight: .medium, design: .default))
                            Spacer()
                            TextField("", text: $tujuanProject).frame(width:180)
                        }
                        HStack {
                            Text("Deskripsi").font(.system(size: 14, weight: .medium, design: .default))
                            Spacer()
                            TextEditor(text: $deskripsiProject)
                                .frame(width:180 ,height:120)
                                .overlay(RoundedRectangle(cornerRadius: 16).stroke(.gray.opacity(0.2), lineWidth: 1))
                        }
                        HStack{
                            Text("Tanggal Mulai").font(.system(size: 14, weight: .medium, design: .default))
                            Spacer()
                            DatePicker("", selection: $startDate, displayedComponents: .date).labelsHidden()
                                .frame(width: 130, height: 40, alignment: .center)
                        }
                        HStack{
                            Text("Tanggal Selesai").font(.system(size: 14, weight: .medium, design: .default))
                            Spacer()
                            DatePicker("", selection: $endDate, displayedComponents: .date).labelsHidden()
                                .frame(width: 130, height: 40, alignment: .center)
                        }
                        HStack{
                            Text("Waktu").font(.system(size: 14, weight: .medium, design: .default))
                            Spacer()
                            DatePicker("", selection: $startTime, displayedComponents: .hourAndMinute).labelsHidden()
                                .frame(width: 90, height: 40, alignment: .center)
                            Text("-")
                            DatePicker("", selection: $endTime, displayedComponents: .hourAndMinute).labelsHidden()
                                .frame(width: 90, height: 40, alignment: .center)
                        }
                        HStack{
                            Text("Lokasi").font(.system(size: 14, weight: .medium, design: .default))
                            Spacer()
                            TextField("", text: $lokasiProject).frame(width:180)
                        }
                    }.frame(width: UIScreen.main.bounds.width/1.2).padding().background(.white).cornerRadius(8)
                    NavigationLink(destination: TaskView()) {
                        Text("Lanjut Bagi Tugas").foregroundColor(.white).font(.system(size: 12, weight: .medium, design: .default)).frame(width: UIScreen.main.bounds.width/1.2,height: 38)
                    }.frame(width: UIScreen.main.bounds.width/1.1,height: 38)
                        .background(.blue)
                        .cornerRadius(12)
                        .padding()
                    Spacer()
                }
                .navigationTitle("Buat Proyek").navigationBarTitleDisplayMode(.inline)
            .textFieldStyle(.roundedBorder).frame(width: UIScreen.main.bounds.width/1.2)
            }
                
        }
        
    }
}

struct CreateProjectView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProjectView()
    }
}

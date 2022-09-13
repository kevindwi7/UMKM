//
//  ProfileView.swift
//  UMKM
//
//  Created by Kevin  Dwi on 24/08/22.
//

import SwiftUI

struct ProfileView: View {
    
//    @State var viewModel = notificationViewModel()
    
    @State var isActive = false
    @State private var vibrationOnRing = true
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    
    var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        return formatter
    }

    
    var body: some View {
        ZStack{
            Color(UIColor.systemGray6).ignoresSafeArea()
            ScrollView{
                //Foto
                ZStack(alignment:.topTrailing){
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .foregroundColor(.black)
                        .padding()
                        .accessibilityLabel("foto profile user")
                        .opacity(0.4)
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 17, height: 16)
                        .foregroundColor(.cyan)
                        .accessibilityLabel("edit gambar profil")
                }.padding()
                //3 kotak

                HStack(){
                        //kotak 1
                    VStack(spacing: 1){
                        Text("Tugas yang\nharus dikerjakan")
                            .multilineTextAlignment(.center)
                                .font(.system(.caption2, design: .rounded))
                                .minimumScaleFactor(0.0001)
                                .lineLimit(4)
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 10, leading: 10, bottom: 5, trailing: 10))
                            Text("50")
                                .font(.system(.title, design: .rounded)).bold()
                                .minimumScaleFactor(0.01)
                                .lineLimit(1)
                                .foregroundColor(.cyan)
                                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                            Text("Tugas")
                                .font(.system(.caption, design: .rounded))
                                .minimumScaleFactor(0.01)
                                .lineLimit(1)
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 5, leading: 10, bottom: 10, trailing: 10))
                    }
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color.white,lineWidth: 1)
                        .background(RoundedRectangle(cornerRadius:10)
                            .foregroundColor(Color.white.opacity(0.2)))    )
                    .frame(width: UIScreen.main.bounds.width/3.5)
                        .foregroundColor(.black)
                        .background( RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(.white))
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel("")
                    
                        //kotak 2
                    VStack(spacing: 2){
                        Text("Tugas yang\nharus dikerjakan")
                            .multilineTextAlignment(.center)
                                .font(.system(.caption2, design: .rounded))
                                .minimumScaleFactor(0.0001)
                                .lineLimit(4)
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 10, leading: 10, bottom: 5, trailing: 10))
                            Text("50")
                                .font(.system(.title, design: .rounded)).bold()
                                .minimumScaleFactor(0.01)
                                .lineLimit(1)
                                .foregroundColor(.cyan)
                                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                            Text("Tugas")
                                .font(.system(.caption, design: .rounded))
                                .minimumScaleFactor(0.01)
                                .lineLimit(1)
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 5, leading: 10, bottom: 10, trailing: 10))
                    }
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color.white,lineWidth: 1)
                        .background(RoundedRectangle(cornerRadius:10)
                            .foregroundColor(Color.white.opacity(0.2)))    )
                    .frame(width: UIScreen.main.bounds.width/3.5)
                        .foregroundColor(.black)
                        .background( RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(.white))
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel("")
                    
                        //kotak3
                    VStack(spacing: 2){
                        Text("Tugas yang \n harus dikerjakan")
                            .multilineTextAlignment(.center)
                                .font(.system(.caption2, design: .rounded))
                                .minimumScaleFactor(0.0001)
                                .lineLimit(4)
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 10, leading: 10, bottom: 5, trailing: 10))
                            Text("50")
                                .font(.system(.title, design: .rounded)).bold()
                                .minimumScaleFactor(0.01)
                                .lineLimit(1)
                                .foregroundColor(.cyan)
                                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                            Text("Tugas")
                                .font(.system(.caption, design: .rounded))
                                .minimumScaleFactor(0.01)
                                .lineLimit(1)
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 5, leading: 10, bottom: 10, trailing: 10))
                    }
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color.white,lineWidth: 1)
                        .background(RoundedRectangle(cornerRadius:10)
                            .foregroundColor(Color.white.opacity(0.2)))    )
                    .frame(width: UIScreen.main.bounds.width/3.5)
                        .foregroundColor(.black)
                        .background( RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(.white))
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel("")
                    
                }
                VStack(alignment:.leading,spacing: 15){
                    HStack{
                        VStack(alignment:.leading,spacing: 6){
                            Text("Nama").font(.system(.caption2, design: .rounded))
                            
                                .minimumScaleFactor(0.01)
                                .lineLimit(1)
                                .foregroundColor(.black)
                            Text("Tania Wilona")
                                .font(.system(.subheadline, design: .rounded)).bold()
                                .minimumScaleFactor(0.01)
                                .lineLimit(1)
                                .foregroundColor(.black)
                                .accessibilityLabel("Jumlah tugas ada satu tugas") //need to further update - vp
                        }
                        Spacer()
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 17, height: 16)
                            .foregroundColor(.cyan)
                            .accessibilityLabel("edit nama")
                    }
                }.padding()
                    .frame(width: UIScreen.main.bounds.width/1.1, alignment:.leading)
                    .background(.white)
                    .cornerRadius(16)
                VStack(alignment:.leading,spacing: 15){
                    HStack{
                        VStack(alignment:.leading,spacing: 6){
                            Text("Komunitas").font(.system(.caption2, design: .rounded))
                            
                                .minimumScaleFactor(0.01)
                                .lineLimit(1)
                                .foregroundColor(.black)
                            Text("Komunitas Mata Hati")
                                .font(.system(.subheadline, design: .rounded)).bold()
                                .minimumScaleFactor(0.01)
                                .lineLimit(1)
                                .foregroundColor(.black)
                                .accessibilityLabel("Komunitas Mata Hati") //need to further update - vp
                        }
                        Spacer()
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 17, height: 16)
                            .foregroundColor(.cyan)
                            .accessibilityLabel("edit nama")
                    }
                }.padding()
                    .frame(width: UIScreen.main.bounds.width/1.1, alignment:.leading)
                    .background(.white)
                    .cornerRadius(16)
                VStack(alignment:.leading,spacing: 15){
                    HStack{
                        VStack(alignment:.leading,spacing: 6){
                            Text("Divisi").font(.system(.caption2, design: .rounded))
                            
                                .minimumScaleFactor(0.01)
                                .lineLimit(1)
                                .foregroundColor(.black)
                            Text("Humas") //need to update - backend for labeling - data dummy divisi
                                .font(.system(.caption, design: .rounded).bold())
                                .foregroundColor(.black.opacity(0.85))
                                .minimumScaleFactor(0.01)
                                .frame(width: 116, height: 30)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .strokeBorder(Color.yellow,lineWidth: 1)
                                        .background(RoundedRectangle(cornerRadius:20)
                                            .foregroundColor(Color.yellow.opacity(0.2)))
                                )
                        }
                        Spacer()
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 17, height: 16)
                            .foregroundColor(.cyan)
                            .accessibilityLabel("edit nama")
                    }
                }.padding()
                    .frame(width: UIScreen.main.bounds.width/1.1, alignment:.leading)
                    .background(.white)
                    .cornerRadius(16)
                
                VStack(alignment:.leading,spacing: 15){
                    HStack{
                       Toggle("Notifikasi", isOn: $vibrationOnRing).font(.system(.headline, design: .rounded))
                            .minimumScaleFactor(0.01)
                            .lineLimit(1)
//                            .foregroundColor(.black)
                            .accessibilityLabel("Komunitas Mata Hati")
                        
                    }
                }.padding()
                    .frame(width: UIScreen.main.bounds.width/1.1, alignment:.leading)
                    .background(.white)
                    .cornerRadius(16)

                VStack{
                    Text("Histori").font(.system(.caption, design: .rounded)).bold()
                    
                        .minimumScaleFactor(0.01)
                        .lineLimit(1)
                        .foregroundColor(.black)
                }.padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                .frame(width: UIScreen.main.bounds.width/1.1, alignment:.leading)
                
                VStack(alignment:.leading,spacing: 10){
                    HStack {
                        Text("Bersih - Bersih Basecamp")
                            .font(.system(.headline, design: .rounded).bold())
                            .minimumScaleFactor(0.01)
                            .scaledFont(name: "", size: 24)
                            .lineLimit(1)
                            .foregroundColor(.black)
                        Spacer()
                        Image(systemName: "chevron.right").foregroundColor(.black)
                            .font(.system(.headline, design: .rounded).bold())
                            .accessibilityHidden(true)
                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    HStack(spacing: 10){
                        Image(systemName: "mappin.and.ellipse").foregroundColor(.black)
                            .font(.system(.body, design: .rounded).bold())
                            .accessibilityHidden(true)
                        Text("Basecamp")
                            .font(.system(.subheadline, design: .rounded))
                            .scaledFont(name: "", size: 14)
                            .minimumScaleFactor(0.01)
                            .lineLimit(1)
                            .foregroundColor(.black)
                    }
                    HStack(spacing: 10){
                        Image(systemName: "calendar")
                            .font(.system(.body, design: .rounded))
                        Text( "15 September 2022")
                            .font(.system(.subheadline, design: .rounded))
                        Text("-")
                            .font(.system(.body, design: .rounded))
                        Text("30 September 2022")
                            .font(.system(.subheadline, design: .rounded))
                        
                    }.scaledFont(name: "", size: 14)
                        .minimumScaleFactor(0.01)
                        .lineLimit(1)
                        .foregroundColor(.black)
                    HStack(spacing: 10){
                        Image(systemName: "clock")
                            .font(.system(.body, design: .rounded))
                        Text("09:30")
                            .font(.system(.subheadline, design: .rounded))
                        Text("-")
                            .font(.system(.body, design: .rounded))
                        Text("15:30")
                            .font(.system(.subheadline, design: .rounded))
                    }                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    
                        .scaledFont(name: "", size: 14)
                        .minimumScaleFactor(0.01)
                        .lineLimit(1)
                        .foregroundColor(.black)
                    HStack{
                        HStack{
                            //tugas
                            HStack{
                                Image(systemName: "doc.text.fill")
                                    .accessibilityHidden(true)
                                    .foregroundColor(.white)
                                    .font(.caption)
                                Spacer().frame(width:20)
                                Text("6/10") //need to update - backend for task - vp
                                    .font(.system(.caption, design: .rounded).bold())
                                    .foregroundColor(.white)
                            }
                            .font(.system(.caption, design: .rounded).bold())
                            .foregroundColor(.white)
                            .frame(width: 116, height: 30)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.cyan))
                            
                            Spacer().frame(width:10)
                            
                            //                        label
                            Text("Humas") //need to update - backend for labeling - vp
                                .font(.system(.caption, design: .rounded).bold())
                                .foregroundColor(.black.opacity(0.85))
                                .minimumScaleFactor(0.01)
                                .frame(width: 116, height: 30)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .strokeBorder(Color.yellow,lineWidth: 1)
                                        .background(RoundedRectangle(cornerRadius:20)
                                            .foregroundColor(Color.yellow.opacity(0.2)))    )
                                .accessibilityLabel("Divisi humas") //need to update - backend for labeling - vp
                            
                        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))

                        
                    }
                }.padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                    .frame(width: UIScreen.main.bounds.width/1.1, alignment:.leading)
                    .background(.white)
                    .cornerRadius(15)
                    .minimumScaleFactor(0.01)
//                    .accessibilityLabel("Proyek \(project.projectName), Lokasi di \(project.location), tanggal mulai \(project.startDate) sampai \(project.endDate), jam kegiatan \(project.startTime) sampai \(project.endTime), tugas yang terisi enam dari sepuluh tugas") // dummy data, need to further update - vp
                
                Button {
                    //Selesaikan project
                    //            self.isLoading = true
                    //            vm.createProject(projectHost: "\(firstName ?? "")\(lastName ?? "")", projectName: namaProjectTask, location: lokasiProjectTask, startTime: startTimeTask, endTime: endTimeTask, participantList: [userID!], description: deskripsiProjectTask, goal: tujuanProjectTask, hostId: userID!, isFinish: isFinish, startDate: startDateTask, endDate: endDateTask, projectID: projectID){
                    self.isActive.toggle()
                }
            label: {
                Text("Keluar").foregroundColor(.white)
                    .font(.system(.caption, design: .rounded)).bold()
                    .frame(width: UIScreen.main.bounds.width/1.1,height: 38)
                    .background(.red)
                    .cornerRadius(12)
                    .padding()
            }
            }
        }

    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

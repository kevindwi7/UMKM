//
//  ProfileView.swift
//  UMKM
//
//  Created by Kevin  Dwi on 24/08/22.
//

import SwiftUI

struct ProfileView: View {
    
//    @State var viewModel = notificationViewModel()
    @State var notification = UserDefaults.standard.bool(forKey: "notification")
    @State var isActive = false
    @State private var vibrationOnRing = true
    @StateObject var nvm:notificationViewModel
    
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
                                .accessibilityLabel("Tugas yang harus dikerjakan")
                            Text("50")
                                .font(.system(.title, design: .rounded)).bold()
                                .minimumScaleFactor(0.01)
                                .lineLimit(1)
                                .foregroundColor(.cyan)
                                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                                .accessibilityLabel("50")
                            Text("Tugas")
                                .font(.system(.caption, design: .rounded))
                                .minimumScaleFactor(0.01)
                                .lineLimit(1)
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 5, leading: 10, bottom: 10, trailing: 10))
                                .accessibilityLabel("Tugas")
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
                        .accessibilityLabel("Jumlah tugas yang harus dikerjakan adalah 50 Tugas")
                    
                        //kotak 2
                    VStack(spacing: 2){
                        Text("Dalam Pengerjaan")
                            .multilineTextAlignment(.center)
                                .font(.system(.caption2, design: .rounded))
                                .minimumScaleFactor(0.0001)
                                .lineLimit(4)
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 10, leading: 10, bottom: 5, trailing: 10))
                                .accessibilityLabel("Dalam Pengerjaan")
                            Text("50")
                                .font(.system(.title, design: .rounded)).bold()
                                .minimumScaleFactor(0.01)
                                .lineLimit(1)
                                .foregroundColor(.cyan)
                                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                                .accessibilityLabel("50")
                            Text("Tugas")
                                .font(.system(.caption, design: .rounded))
                                .minimumScaleFactor(0.01)
                                .lineLimit(1)
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 5, leading: 10, bottom: 10, trailing: 10))
                                .accessibilityLabel("Tugas")
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
                        .accessibilityLabel("Jumlah tugas dalam pengerjaan adalah 50 Tugas")
                    
                        //kotak3
                    VStack(spacing: 2){
                        Text("Selesai")
                            .multilineTextAlignment(.center)
                                .font(.system(.caption2, design: .rounded))
                                .minimumScaleFactor(0.0001)
                                .lineLimit(4)
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 10, leading: 10, bottom: 5, trailing: 10))
                                .accessibilityLabel("Selesai")
                            Text("50")
                                .font(.system(.title, design: .rounded)).bold()
                                .minimumScaleFactor(0.01)
                                .lineLimit(1)
                                .foregroundColor(.cyan)
                                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                                .accessibilityLabel("50")
                            Text("Tugas")
                                .font(.system(.caption, design: .rounded))
                                .minimumScaleFactor(0.01)
                                .lineLimit(1)
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 5, leading: 10, bottom: 10, trailing: 10))
                                .accessibilityLabel("Tugas")
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
                        .accessibilityLabel("Jumlah tugas selesai adalah 50 Tugas")
                    
                }
                VStack(alignment:.leading,spacing: 15){
                    HStack{
                        VStack(alignment:.leading,spacing: 6){
                            Text("Nama").font(.system(.caption2, design: .rounded))
                            
                                .minimumScaleFactor(0.01)
                                .lineLimit(1)
                                .foregroundColor(.black)
                                .accessibilityLabel("Nama")
                            Text("Tania Wilona")
                                .font(.system(.subheadline, design: .rounded)).bold()
                                .minimumScaleFactor(0.01)
                                .lineLimit(1)
                                .foregroundColor(.black)
                                .accessibilityLabel("Tania Wilona") //need to further update - vp
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
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("Nama Tania Wilona")
                
                VStack(alignment:.leading,spacing: 15){
                    HStack{
                        VStack(alignment:.leading,spacing: 6){
                            Text("Komunitas").font(.system(.caption2, design: .rounded))
                            
                                .minimumScaleFactor(0.01)
                                .lineLimit(1)
                                .foregroundColor(.black)
                                .accessibilityLabel("Komunitas")
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
                            .accessibilityLabel("edit komunitas")
                    }
                }.padding()
                    .frame(width: UIScreen.main.bounds.width/1.1, alignment:.leading)
                    .background(.white)
                    .cornerRadius(16)
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("Komunitas Mata Hati")
                
                VStack(alignment:.leading,spacing: 15){
                    HStack{
                        VStack(alignment:.leading,spacing: 6){
                            Text("Divisi").font(.system(.caption2, design: .rounded))
                            
                                .minimumScaleFactor(0.01)
                                .lineLimit(1)
                                .foregroundColor(.black)
                                .accessibilityLabel("Divisi")
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
                                .accessibilityLabel("Humas")
                        }
                        Spacer()
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 17, height: 16)
                            .foregroundColor(.cyan)
                            .accessibilityLabel("edit divisi")
                    }
                }.padding()
                    .frame(width: UIScreen.main.bounds.width/1.1, alignment:.leading)
                    .background(.white)
                    .cornerRadius(16)
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("Divisi Humas")
                
                VStack(alignment:.leading,spacing: 15){
                    HStack{
                        Toggle("Notifikasi", isOn: $notification).font(.system(.headline, design: .rounded))
                            .minimumScaleFactor(0.01)
                            .lineLimit(1)
//                            .foregroundColor(.black)
                            .accessibilityLabel("Komunitas Mata Hati")
                            .onChange(of: notification) { newValue in
                                if(notification == false){
                                    UserDefaults.standard.set(false, forKey: "notification")
                                    nvm.unsubscribeNotifications()
                                }else{
                                    UserDefaults.standard.set(true, forKey: "notification")
                                    nvm.subscribeToNotifications{finish in
                                        print("Success to unsubscribe")
                                    }
                                }
                            }
                        
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
                        .accessibilityLabel("Histori")
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
                            .accessibilityLabel("Bersih - Bersih Basecamp")
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
                            .accessibilityLabel("Basecamp")
                    }
                    HStack(spacing: 10){
                        Image(systemName: "calendar")
                            .font(.system(.body, design: .rounded))
                            .accessibilityLabel("calendar")
                        Text( "15 September 2022")
                            .font(.system(.subheadline, design: .rounded))
                            .accessibilityLabel("15 September 2022")
                        Text("-")
                            .font(.system(.body, design: .rounded))
                        Text("30 September 2022")
                            .font(.system(.subheadline, design: .rounded))
                            .accessibilityLabel("30 September 2022")
                        
                    }.scaledFont(name: "", size: 14)
                        .minimumScaleFactor(0.01)
                        .lineLimit(1)
                        .foregroundColor(.black)
                    HStack(spacing: 10){
                        Image(systemName: "clock")
                            .font(.system(.body, design: .rounded))
                            .accessibilityLabel("clock")
                        Text("09:30")
                            .font(.system(.subheadline, design: .rounded))
                            .accessibilityLabel("Pukul 09:30 Waktu Indonesia Barat")
                        Text("-")
                            .font(.system(.body, design: .rounded))
                        Text("15:30")
                            .font(.system(.subheadline, design: .rounded))
                            .accessibilityLabel("Tugas yang harus dikerjakan")
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        .accessibilityLabel("Pukul 15:30 Waktu Indonesia Barat")
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
                    .accessibilityLabel("Keluar")
            }
            }
        }

    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(nvm: notificationViewModel())
    }
}

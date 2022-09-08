//
//  DetailProjectCard4Views.swift
//  UMKM
//
//  Created by Vidya on 08/09/22.
//

import SwiftUI
import CloudKit

struct DetailProjectCard4Views: View {
    
    @State var isActive = false
    
    @State var action: Int? = 0
    
    @Binding var project3: ProjectViewModel
    //    @Binding var task: TaskViewModel
    //    @State var action: Int? = 0
    
    let firstName = UserDefaults.standard.object(forKey: "firstName") as? String
    let lastName = UserDefaults.standard.object(forKey: "lastName") as? String
    let userID = UserDefaults.standard.object(forKey: "userID") as? String
    
    //    print(project3.participantList)
    
    
    var body: some View {
        Spacer()
        Button(action: {
//            self.isActive = !self.isActive
            withAnimation(.easeInOut){self.isActive = !self.isActive}
        }){
            VStack(alignment:.leading,spacing: 15){
                HStack{
                    VStack(alignment:.leading, spacing: 6){
                        Text("Anggota")
                            .font(.system(.footnote, design: .rounded)).bold()
                            .scaledFont(name: "", size: 14)
                            .minimumScaleFactor(0.01)
                            .lineLimit(1)
                            .foregroundColor(.black)
                        Text("\(project3.participantList.count) Orang")
                            .font(.system(.caption, design: .rounded))
                            .scaledFont(name: "", size: 12)
                            .minimumScaleFactor(0.01)
                            .lineLimit(1)
                            .foregroundColor(.black)
                            .accessibilityLabel("Jumlah anggota \(project3.participantList.count) orang")
                    }
                    Spacer()
                    Image(systemName: self.isActive == true ? "chevron.down" : "chevron.up")
                        .font(.system(.headline, design: .rounded).bold())
                        .accessibilityHidden(true)
                }
                //
                //                NavigationLink(destination: {
                //                    DetailProjectParticipantView(projectParticipant: $project3)
                //                }, label: {
                //                    Text("Detail Anggota")
                //                        .font(.system(.caption, design: .rounded).bold())
                //                        .foregroundColor(.white)
                //                        .frame(width: 130, height: 30)
                //                        .background(RoundedRectangle(cornerRadius: 10).fill(.cyan))
                //                        .accessibilityLabel("Tombol lihat anggota terdaftar")
                //                })
                
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width/1.1, alignment:.leading)
            .background(.white)
            .cornerRadius(16)
            
            
        }
//   Form{
//       Section{
        ForEach (project3.participantList, id: \.self){ item in
//            VStack(alignment:.leading, spacing: 15){
                HStack(alignment:.top, spacing: 15){
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40.8, height: 40.8)
                        .foregroundColor(.black)
                        .accessibilityLabel("foto Tania") // need to further update dummy - vp
                    VStack(alignment:.leading){
                        Text("Nama") // need to further update dummy - vp
                            .font(.system(.body, design: .rounded)).bold()
                            .minimumScaleFactor(0.01)
                            .lineLimit(1)
                            .foregroundColor(.black)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))
                            .accessibilityLabel("..... blabla") // need to further update dummy - vp
                        Text("Sapu halaman depan") // need to further update dummy - vp
                            .font(.system(.caption, design: .rounded))
                            .scaledFont(name: "", size: 12)
                            .minimumScaleFactor(0.01)
                            .lineLimit(1)
                            .foregroundColor(.black)
                            .accessibilityLabel("..... blabla") // need to further update dummy - vp
                        Text("Atur Keuangan (Bendahara)") // need to further update dummy - vp
                            .font(.system(.caption, design: .rounded))
                            .scaledFont(name: "", size: 12)
                            .minimumScaleFactor(0.01)
                            .lineLimit(1)
                            .foregroundColor(.black)
                            .accessibilityLabel("..... blabla") // need to further update dummy - vp
                    }
                }.padding()
                    .frame(width: UIScreen.main.bounds.width/1.1, alignment:.leading)
                    .background(.white)
                    .cornerRadius(16)
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: self.isActive ? 0 : .none)
            .clipped()
//                        .animation(.easeOut)
//                        .transition(.slide)
        }
    }

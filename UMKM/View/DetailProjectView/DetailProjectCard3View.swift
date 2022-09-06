//
//  DetailProjectCard3View.swift
//  UMKM
//
//  Created by Kevin  Dwi on 29/08/22.
//

import SwiftUI
import CloudKit

struct DetailProjectCard3View: View {
//    @StateObject var hm:HomeViewModel
    
    @Binding var project3: ProjectViewModel
//    @Binding var task: TaskViewModel
    @State var action: Int? = 0
    
//    init(vm: HomeViewModel, project3: Binding<ProjectViewModel>, task: Binding<TaskViewModel>) {
//        _vm = StateObject(wrappedValue: vm)
//        self._project3 = project3
//        self._task = task
//    }
    
    var body: some View {
        VStack(alignment:.leading){
            Text("Anggota :").font(.system(size: 14, weight: .bold, design: .rounded))
            HStack{
                Text("\(project3.participantList.count) orang").font(.system(size: 14, weight: .regular, design: .rounded))
                    .accessibilityLabel("Jumlah anggota \(project3.participantList.count) orang")
                Spacer()
                NavigationLink(destination: {
                    DetailProjectParticipantView(projectParticipant: $project3)
                }, label: {
                    Text("Detail Anggota")
                        .frame(width: 110, height: 26)
                        .padding(.all,4)
                        .font(.system(size: 14,weight: .regular, design: .rounded))
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 8))
                        .accessibilityLabel("Tombol lihat anggota terdaftar")
               
                        
                        
                })
            }
           
            Text("Tugas :").font(.system(size: 14, weight: .bold, design: .rounded))
            HStack{
                Text("1 Tugas").font(.system(size: 14, weight: .regular, design: .rounded))
                    .accessibilityLabel("Jumlah tugas ada satu tugas") //need to further update - vp
                Spacer()
                NavigationLink(destination: {
                    DetailProjectTaskCard(vm: HomeViewModel(container: CKContainer.default()), project: $project3)
//                    TabBarView()
                }, label: {
                    Text("Detail Tugas")
                        .frame(width: 110, height: 26)
                        .padding(.all,4)
                        .font(.system(size: 14,weight: .regular, design: .rounded))
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 8))
                        .accessibilityLabel("Tombol lihat detail tugas")
               
                        
                        
                })
//                Button {
//                    //handle assign to me
//                    print("Test")
//                } label: {
//                    Text("Detail Tugas").font(.system(size: 12, weight: .regular, design: .default))
//                }
//                .background(.blue)
//                .frame(width: 150,height: 25)
//                .cornerRadius(8)
//                .foregroundColor(.white)
            }
  
        }.padding()
            .frame(width: UIScreen.main.bounds.width/1.1, alignment:.leading)
            .background(.white)
            .cornerRadius(16)
    }
    
}

//struct DetailProjectCard3View_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailProjectCard3View()
//    }
//}

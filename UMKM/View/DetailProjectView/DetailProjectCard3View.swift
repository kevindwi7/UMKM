//
//  DetailProjectCard3View.swift
//  UMKM
//
//  Created by Kevin  Dwi on 29/08/22.
//

import SwiftUI

struct DetailProjectCard3View: View {
    @Binding var project3: ProjectViewModel
    @State var action: Int? = 0
    
    var body: some View {
        VStack(alignment:.leading,spacing: 10){
            Text("Anggota :").font(.system(size: 17, weight: .bold, design: .default))
            
            HStack{
                Text("\(project3.participantList.count) orang").font(.system(size: 12, weight: .regular, design: .default))
                Spacer()
                NavigationLink(destination: {
                    DetailProjectParticipantView(projectParticipant: $project3)
                }, label: {
                    Text("Detail Anggota")
                        .padding(.all,4)
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 8))
               
                        
                        
                })
            }
           
            Text("Tugas :").font(.system(size: 17, weight: .bold, design: .default))
            HStack{
                Text("10 Tugas").font(.system(size: 12, weight: .regular, design: .default))
                Spacer()
                NavigationLink(destination: {
                    DetailProjectTaskCard(test: $project3 )
                }, label: {
                    Text("Detail Tugas")
                        .padding(.all,4)
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 8))
               
                        
                        
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

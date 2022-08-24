//
//  DetailProjectCardView.swift
//  UMKM
//
//  Created by Kevin  Dwi on 24/08/22.
//

import SwiftUI

struct DetailProjectCardView: View {
    @Binding var project: ProjectViewModel
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    
    var body: some View {
        VStack(alignment:.leading,spacing: 15){
            Group{
                HStack{
                    Image("location").resizable().scaledToFit().frame(width: 20, height: 20)
                    Text("Lokasi : ").font(.system(size: 12, weight: .medium, design: .default))
                    Text(project.location).font(.system(size: 12, weight: .medium, design: .default))
                }
                HStack{
                    Image(systemName: "calendar").resizable().scaledToFit().frame(width: 20, height: 20)
                    Text("Waktu : ").font(.system(size: 12, weight: .medium, design: .default))
                    Text(dateFormatter.string(from: project.startTime))
                    Text("|")
                    Text("8.00 - 10.00 AM")
                }.font(.system(size: 12, weight: .medium, design: .default))
                HStack{
                    Image(systemName: "person").resizable().scaledToFit().frame(width: 20, height: 20)
                    Text("Ideator : ").font(.system(size: 12, weight: .medium, design: .default))
                    Text(project.projectHost).font(.system(size: 12, weight: .medium, design: .default))
                }
            }
            Text("Tujuan :").font(.system(size: 17, weight: .bold, design: .default))
            Text(project.goal).font(.system(size: 12, weight: .regular, design: .default))
            Text("Deskripsi :").font(.system(size: 17, weight: .bold, design: .default))
            Text(project.description).font(.system(size: 12, weight: .regular, design: .default)).fixedSize(horizontal: false, vertical: true)
            HStack{
                Image(systemName: "person.circle.fill")
                Text("\(project.participant) Participants").font(.system(size: 12, weight: .regular, design: .default))
            }
        }.padding()
            .frame(width: UIScreen.main.bounds.width/1.2, alignment:.leading)
            .background(.white)
            .cornerRadius(16)
    }
}

//struct DetailProjectCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailProjectCardView()
//    }
//}


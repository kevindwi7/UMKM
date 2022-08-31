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
    
    var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        return formatter
    }
    
    var body: some View {
        VStack(alignment:.leading,spacing: 15){
            Text("Detail").font(.system(size: 18, weight: .bold, design: .default))
            Group{
                HStack{
                    Image("location").resizable().scaledToFit().frame(width: 20, height: 20)
                        .accessibilityHidden(true)
                    Text("Lokasi : ").font(.system(size: 12, weight: .medium, design: .default))
                    Text(project.location).font(.system(size: 12, weight: .medium, design: .default))
                }
                .accessibilityElement(children: .combine)
                .accessibilityLabel("Lokasi kegiatan di \(project.location)")
                HStack{
                    Image(systemName: "calendar").resizable().scaledToFit().frame(width: 20, height: 20)
                        .accessibilityHidden(true)
                    Text("Waktu : ").font(.system(size: 12, weight: .medium, design: .default))
                    Text(dateFormatter.string(from: project.startDate))
                    Text("|")
                    Text("\(timeFormatter.string(from: project.startTime)) - \(timeFormatter.string(from: project.endTime))")
                }.font(.system(size: 12, weight: .medium, design: .default))
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("waktu kegiatan pada hari \(dateFormatter.string(from: project.startTime)) di jam delapan sampai jam 10 pagi") //need to further update - vp
                HStack{
                    Image(systemName: "person").resizable().scaledToFit().frame(width: 20, height: 20)
                        .accessibilityHidden(true)
                    Text("Ideator : ").font(.system(size: 12, weight: .medium, design: .default))
                    Text(project.projectHost).font(.system(size: 12, weight: .medium, design: .default))
                }.accessibilityElement(children: .combine)
                    .accessibilityLabel("Ideator proyek \(project.projectHost)") //need to further update - vp
            }
//            HStack{
//                Image(systemName: "person.circle.fill")
//                Text("\(project.participantList.count) member telah bergabung").font(.system(size: 12, weight: .regular, design: .default))
//            }
        }.padding()
            .frame(width: UIScreen.main.bounds.width/1.1, alignment:.leading)
            .background(.white)
            .cornerRadius(16)
    }
}

//struct DetailProjectCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailProjectCardView()
//    }
//}


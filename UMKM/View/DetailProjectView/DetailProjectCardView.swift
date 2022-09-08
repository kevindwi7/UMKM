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
        VStack(alignment:.leading,spacing: 14){
            //            Text("Detail").font(.system(size: 18, weight: .bold, design: .default))
                VStack(alignment:.leading, spacing: 6){
                    //                    Image("location").resizable().scaledToFit().frame(width: 20, height: 20)
                    //                        .accessibilityHidden(true)
                    Text("Lokasi")
                        .font(.system(.footnote, design: .rounded)).bold()
                        .scaledFont(name: "", size: 14)
                        .minimumScaleFactor(0.01)
                        .lineLimit(1)
                        .foregroundColor(.black)
                    Text(project.location)
                        .font(.system(.caption, design: .rounded))
                        .scaledFont(name: "", size: 14)
                        .minimumScaleFactor(0.01)
                        .lineLimit(1)
                        .foregroundColor(.black)
                }
                .accessibilityElement(children: .combine)
                .accessibilityLabel("Lokasi kegiatan di \(project.location)")
            
                VStack(alignment:.leading, spacing: 6){
                    //                    Image(systemName: "calendar").resizable().scaledToFit().frame(width: 20, height: 20)
                    //                        .accessibilityHidden(true)
                    Text("Tanggal")
                        .font(.system(.footnote, design: .rounded)).bold()
                        .scaledFont(name: "", size: 14)
                        .minimumScaleFactor(0.01)
                        .lineLimit(1)
                        .foregroundColor(.black)
                    HStack{
                        Text(dateFormatter.string(from: project.startDate))
                        Text("-")
                        Text(dateFormatter.string(from: project.endDate))
                        //                        Text("\(timeFormatter.string(from: project.startTime)) - \(timeFormatter.string(from: project.endTime))")
                    }.font(.system(.caption, design: .rounded))
                        .scaledFont(name: "", size: 14)
                        .minimumScaleFactor(0.01)
                        .lineLimit(1)
                        .foregroundColor(.black)
                }   .accessibilityElement(children: .combine)
                    .accessibilityLabel("Tanggal kegiatan pada hari \(dateFormatter.string(from: project.startDate))")
            
                VStack(alignment:.leading, spacing: 6){
                    //                    Image(systemName: "calendar").resizable().scaledToFit().frame(width: 20, height: 20)
                    //                        .accessibilityHidden(true)
                    Text("Waktu")
                        .font(.system(.footnote, design: .rounded)).bold()
                        .scaledFont(name: "", size: 14)
                        .minimumScaleFactor(0.01)
                        .lineLimit(1)
                        .foregroundColor(.black)
                    HStack{
                        Text(timeFormatter.string(from: project.startTime))
                        Text("-")
                        Text(timeFormatter.string(from: project.endTime))
                        //                        Text("\(timeFormatter.string(from: project.startTime)) - \(timeFormatter.string(from: project.endTime))")
                    }.font(.system(.caption, design: .rounded))
                        .scaledFont(name: "", size: 14)
                        .minimumScaleFactor(0.01)
                        .lineLimit(1)
                        .foregroundColor(.black)
                }
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("di jam \(timeFormatter.string(from: project.startTime)) sampai \(timeFormatter.string(from: project.endTime))")
                VStack (alignment:.leading, spacing: 6){
                    //                    Image(systemName: "person").resizable().scaledToFit().frame(width: 20, height: 20)
                    //                        .accessibilityHidden(true)
                    Text("Ideator")
                        .font(.system(.footnote, design: .rounded)).bold()
                        .scaledFont(name: "", size: 14)
                        .minimumScaleFactor(0.01)
                        .lineLimit(1)
                        .foregroundColor(.black)
                    Text(project.projectHost)
                        .font(.system(.caption, design: .rounded))
                        .scaledFont(name: "", size: 14)
                        .minimumScaleFactor(0.01)
                        .lineLimit(1)
                        .foregroundColor(.black)
                }.accessibilityElement(children: .combine)
                    .accessibilityLabel("Ideator proyek \(project.projectHost)")
            
            VStack(alignment:.leading, spacing: 6){
                //                    Image("location").resizable().scaledToFit().frame(width: 20, height: 20)
                //                        .accessibilityHidden(true)
                Text("Divisi")
                    .font(.system(.footnote, design: .rounded)).bold()
                    .scaledFont(name: "", size: 14)
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
                                .foregroundColor(Color.yellow.opacity(0.2)))    )
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Divisi humas") //need to further update, data dummy divisi - vp
         
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


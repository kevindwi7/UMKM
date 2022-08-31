//
//  ProjectCardView.swift
//  UMKM
//
//  Created by Trevincen Tambunan on 24/08/22.
//

import SwiftUI

struct ProjectCardView: View {
    @StateObject var vm: HomeViewModel
    @State var isActive = false
    @Binding var project: ProjectViewModel
//    @State var task: TaskViewModel
    @State var isListRoomView = false
    
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
    let userID = UserDefaults.standard.object(forKey: "userID") as? String
    
    var body: some View {
        Button(action: {
            self.isActive = true
            
        }){
            VStack(alignment:.leading,spacing: 8){
                HStack {
                    Text(project.projectName)
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.01)
                        .scaledFont(name: "", size: 24)
                        .lineLimit(1)
                    .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.right").foregroundColor(.black)
                        .accessibilityHidden(true)
                }
                HStack{
                    Image(systemName: "mappin.and.ellipse").foregroundColor(.black)
                        .accessibilityHidden(true)
                    Text(project.location)
                        .scaledFont(name: "", size: 14)
                        .minimumScaleFactor(0.01)
                        .lineLimit(1)
                        .foregroundColor(.black)
                }
                HStack{
                    Image(systemName: "calendar")
                    Text(dateFormatter.string(from: project.startDate))
                    Text("-")
                    Text(dateFormatter.string(from: project.endDate))
                }.scaledFont(name: "", size: 14)
                    .minimumScaleFactor(0.01)
                    .lineLimit(1)
                    .foregroundColor(.black)
                HStack{
                    Image(systemName: "clock")
                    Text(timeFormatter.string(from: project.startTime))
                    Text("-")
                    Text(timeFormatter.string(from: project.endTime))
                }.scaledFont(name: "", size: 14)
                    .minimumScaleFactor(0.01)
                    .lineLimit(1)
                    .foregroundColor(.black)
                HStack{
                    Spacer()
                    HStack{
                        Image(systemName: "doc.text.fill")
                            .accessibilityHidden(true)
                        Spacer().frame(width:20)
                        Text("6/10").font(.system(size: 14, weight: .medium, design: .default))
                            .minimumScaleFactor(0.01)
                    }.padding(5).background(
                        RoundedRectangle(cornerRadius: 12)
                            .strokeBorder(Color.blue, lineWidth: 1))
                }
            }.padding()
                .frame(width: UIScreen.main.bounds.width/1.1, alignment:.leading)
                .background(.white)
                .cornerRadius(15)
//                .minimumScaleFactor(0.01)
                .accessibilityLabel("Proyek \(project.projectName), Lokasi di \(project.location), tanggal mulai dua satu januari sampai tanggal dua puluh lima januari dua ribu dua dua, jam kegiatan delapan lima puluh pagi sampai empat empat puluh sore, tugas yang terisi enam dari sepuluh tugas") // dummy data, need to further update - vp
        }
        .background(
            NavigationLink(destination: DetailProjectView(vm: self.vm, project: $project), isActive: $isActive, label: {
                EmptyView()
            })
        )
    }
}

//struct ProjectCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProjectCardView()
//    }
//}

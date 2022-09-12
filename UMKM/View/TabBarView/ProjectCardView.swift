//
//  ProjectCardView.swift
//  UMKM
//
//  Created by Trevincen Tambunan on 24/08/22.
//

import SwiftUI
import CloudKit

struct ProjectCardView: View {
    @StateObject var vm: HomeViewModel
    @StateObject var mvm: MainViewModel
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
            VStack(alignment:.leading,spacing: 10){
                HStack {
                    Text(project.projectName)
                        .font(.system(.title3, design: .rounded).bold())
                        .minimumScaleFactor(0.01)
                        .scaledFont(name: "", size: 24)
                        .lineLimit(1)
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.right").foregroundColor(.black)
                        .font(.system(.body, design: .rounded).bold())
                        .accessibilityHidden(true)
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                HStack(spacing: 10){
                    Image(systemName: "mappin.and.ellipse").foregroundColor(.black)
                        .font(.system(.body, design: .rounded).bold())
                        .accessibilityHidden(true)
                    Text(project.location)
                        .font(.system(.subheadline, design: .rounded))
                        .scaledFont(name: "", size: 14)
                        .minimumScaleFactor(0.01)
                        .lineLimit(1)
                        .foregroundColor(.black)
                }
                HStack(spacing: 10){
                    Image(systemName: "calendar")
                        .font(.system(.body, design: .rounded))
                    Text(dateFormatter.string(from: project.startDate))
                        .font(.system(.subheadline, design: .rounded))
                    Text("-")
                        .font(.system(.body, design: .rounded))
                    Text(dateFormatter.string(from: project.endDate))
                        .font(.system(.subheadline, design: .rounded))
                    
                }.scaledFont(name: "", size: 14)
                    .minimumScaleFactor(0.01)
                    .lineLimit(1)
                    .foregroundColor(.black)
                HStack(spacing: 10){
                    Image(systemName: "clock")
                        .font(.system(.body, design: .rounded))
                    Text(timeFormatter.string(from: project.startTime))
                        .font(.system(.subheadline, design: .rounded))
                    Text("-")
                        .font(.system(.body, design: .rounded))
                    Text(timeFormatter.string(from: project.endTime))
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
                .accessibilityLabel("Proyek \(project.projectName), Lokasi di \(project.location), tanggal mulai \(project.startDate) sampai \(project.endDate), jam kegiatan \(project.startTime) sampai \(project.endTime), tugas yang terisi enam dari sepuluh tugas") // dummy data, need to further update - vp
        }
        .background(
            NavigationLink(destination: DetailProjectView(vm: self.vm, mvm: self.mvm, project: $project), isActive: $isActive, label: {
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

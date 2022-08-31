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
    @State var isListRoomView = false
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
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
                        .font(.system(size: 18, weight: .bold, design: .default))
                        .minimumScaleFactor(0.01)
                    .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.right").foregroundColor(.black)
                        .accessibilityHidden(true)
                }
                HStack{
                    Image("location").resizable().frame(width: 15, height: 18).scaledToFit()
                        .accessibilityHidden(true)
                    Text(project.location)
                        .font(.system(size: 14, weight: .medium, design: .default))
                        .minimumScaleFactor(0.01)
                        .foregroundColor(.black)
                }
                HStack{
                    Image(systemName: "calendar")
                        .accessibilityHidden(true)
                    Text("21 Jan 2022")
                    Text("-")
                    Text("25 Jan 2022")
                }.font(.system(size: 14, weight: .medium, design: .default))
                    .minimumScaleFactor(0.01)
                    .foregroundColor(.black)
                HStack{
                    Image(systemName: "clock")
                        .accessibilityHidden(true)
                    Text("08.50")
                    Text("-")
                    Text("16.40")
                }.font(.system(size: 14, weight: .medium, design: .default)).foregroundColor(.black)
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

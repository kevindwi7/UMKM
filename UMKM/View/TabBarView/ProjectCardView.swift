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
                    .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.right").foregroundColor(.black)
                }
                HStack{
                    Image("location").resizable().frame(width: 15, height: 18).scaledToFit()
                    Text(project.location)
                        .font(.system(size: 14, weight: .medium, design: .default))
                        .foregroundColor(.black)
                }
                HStack{
                    Image(systemName: "calendar")
                    Text("21 Jan 2022")
                    Text("-")
                    Text("25 Jan 2022")
                }.font(.system(size: 14, weight: .medium, design: .default)).foregroundColor(.black)
                HStack{
                    Image(systemName: "clock")
                    Text("08.50")
                    Text("-")
                    Text("16.40")
                }.font(.system(size: 14, weight: .medium, design: .default)).foregroundColor(.black)
                HStack{
                    Spacer()
                    HStack{
                        Image(systemName: "doc.text")
                        Spacer().frame(width:20)
                        Text("6/10").font(.system(size: 14, weight: .medium, design: .default))
                    }.padding(5).background(
                        RoundedRectangle(cornerRadius: 12)
                            .strokeBorder(Color.blue, lineWidth: 1))
                }
            }.padding()
                .frame(width: UIScreen.main.bounds.width/1.1, alignment:.leading)
                .background(.white)
                .cornerRadius(15)
        }.background(
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

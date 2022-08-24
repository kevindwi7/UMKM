//
//  ProjectCardView.swift
//  UMKM
//
//  Created by Trevincen Tambunan on 24/08/22.
//

import SwiftUI

struct ProjectCardView: View {
    @StateObject var vm: MainViewModel
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
                Text(project.projectName)
                    .font(.system(size: 15, weight: .bold, design: .default))
                    .foregroundColor(.black)
                HStack{
                    Image("location").resizable().frame(width: 15, height: 18).scaledToFit()
                    Text(project.location)
                        .font(.system(size: 12, weight: .medium, design: .default))
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.right").foregroundColor(.black)
                }
                HStack{
                    Image(systemName: "calendar")
                    Text(dateFormatter.string(from: project.startTime)).foregroundColor(.black)
                    Text("|").foregroundColor(.black)
                    Text("8.00 - 10.00 AM").foregroundColor(.black)
                }.font(.system(size: 12, weight: .medium, design: .default)).foregroundColor(.black)
            }.padding()
                .frame(width: UIScreen.main.bounds.width/1.2, alignment:.leading)
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

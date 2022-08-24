//
//  DetailProjectView.swift
//  UMKM
//
//  Created by Kevin  Dwi on 24/08/22.
//

import SwiftUI

struct DetailProjectView: View {
    
    @State var isProjectJoined = false
    @StateObject var vm: MainViewModel
    @State var isActive = false
    @Binding var project: ProjectViewModel
    
    var body: some View {
        ZStack{
            Color.primaryGray.ignoresSafeArea()
            VStack(alignment:.leading){
                Text(project.projectName).font(.system(size: 25, weight: .bold, design: .default))
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 20)
                    .frame(width: 200, height: 60)
                DetailProjectCardView(project: $project)
                if !isProjectJoined {
                    Button {
                        //handle join project
                        self.isProjectJoined.toggle()
                    } label: {
                        Text("Join Project").foregroundColor(.white)
                    }.frame(width: UIScreen.main.bounds.width/1.2,height: 38)
                        .background(.blue)
                        .cornerRadius(12)
                }
                DetailProjectTaskCard(isProjectJoined: $isProjectJoined)

            }
        }
        
        
    }
}

//struct DetailProjectView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailProjectView()
//    }
//}


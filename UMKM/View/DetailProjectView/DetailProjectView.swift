//
//  DetailProjectView.swift
//  UMKM
//
//  Created by Trevincen Tambunan on 24/08/22.
//

import SwiftUI

struct DetailProjectView: View {
    
    @State var isProjectJoined = false
    
    var body: some View {
        ZStack{
            Color.primaryGray.ignoresSafeArea()
            VStack(alignment:.leading){
                Text("Bersih bersih basecamp ").font(.system(size: 25, weight: .bold, design: .default))
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 20)
                    .frame(width: 200, height: 60)
                DetailProjectCardView()
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

struct DetailProjectView_Previews: PreviewProvider {
    static var previews: some View {
        DetailProjectView()
    }
}

//
//  ProjectCardView.swift
//  UMKM
//
//  Created by Trevincen Tambunan on 24/08/22.
//

import SwiftUI

struct ProjectCardView: View {
    
    @Binding var isShowingDetailProjectView:Bool
    var body: some View {
        VStack(alignment:.leading,spacing: 8){
            Text("Bersih bersih basecamp").font(.system(size: 15, weight: .bold, design: .default))
            HStack{
                Image("location").resizable().scaledToFit().frame(width: 20, height: 20)
                Text("Basecamp").font(.system(size: 12, weight: .medium, design: .default))
                Spacer()
                Image(systemName: "chevron.right")
            }
            HStack{
                Image(systemName: "calendar").resizable().scaledToFit().frame(width: 20, height: 20)
                Text("21 Aug 22")
                Text("|")
                Text("8.00 - 10.00 AM")
            }.font(.system(size: 12, weight: .medium, design: .default))
        }.padding()
            .frame(width: UIScreen.main.bounds.width/1.2, alignment:.leading)
        .background(.white)
        .cornerRadius(16)
        .onTapGesture {
            isShowingDetailProjectView.toggle()
        }
    }
}

struct ProjectCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectCardView(isShowingDetailProjectView: .constant(false))
    }
}

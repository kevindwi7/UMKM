//
//  DetailProjecrCard2View.swift
//  UMKM
//
//  Created by Kevin  Dwi on 29/08/22.
//

import SwiftUI

struct DetailProjecrCard2View: View {
    @Binding var project2: ProjectViewModel
    var body: some View {
        VStack(alignment:.leading,spacing: 15){
            Text("Tujuan :").font(.system(size: 17, weight: .bold, design: .default))
            Text(project2.goal).font(.system(size: 12, weight: .regular, design: .default))
            Text("Deskripsi :").font(.system(size: 17, weight: .bold, design: .default))
            Text(project2.description).font(.system(size: 12, weight: .regular, design: .default)).fixedSize(horizontal: false, vertical: true)
        }.padding()
            .frame(width: UIScreen.main.bounds.width/1.2, alignment:.leading)
            .background(.white)
            .cornerRadius(16)
    }
}

//struct DetailProjecrCard2View_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailProjecrCard2View()
//    }
//}

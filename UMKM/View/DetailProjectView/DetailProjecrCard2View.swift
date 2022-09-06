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
            Text("Tujuan :").font(.system(size: 14, weight: .bold, design: .rounded))
            Text(project2.goal).font(.system(size: 14, weight: .regular, design: .rounded))
                .accessibilityElement(children: .combine)
                .accessibilityLabel("Tujuan proyek ini \(project2.goal)")
            Text("Deskripsi :").font(.system(size: 14, weight: .bold, design: .rounded))
            Text(project2.description).font(.system(size: 14, weight: .regular, design: .rounded)).fixedSize(horizontal: false, vertical: true)
                .accessibilityElement(children: .combine)
                .accessibilityLabel("Deskripsi proyek ini \(project2.description)")
        }.padding()
            .frame(width: UIScreen.main.bounds.width/1.1, alignment:.leading)
            .background(.white)
            .cornerRadius(16)
    }
}

//struct DetailProjecrCard2View_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailProjecrCard2View()
//    }
//}

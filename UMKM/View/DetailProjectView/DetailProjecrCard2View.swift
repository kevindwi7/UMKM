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
        VStack(alignment:.leading,spacing: 20){
            VStack(alignment:.leading, spacing: 6){
                Text("Tujuan")
                    .font(.system(.footnote, design: .rounded)).bold()
                    .scaledFont(name: "", size: 14)
                    .minimumScaleFactor(0.01)
                    .lineLimit(1)
                    .foregroundColor(.black)
                Text(project2.goal)
                    .font(.system(.caption, design: .rounded))
                    .scaledFont(name: "", size: 12)
                    .minimumScaleFactor(0.01)
                    .lineLimit(1)
                .foregroundColor(.black)
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Tujuan proyek ini \(project2.goal)")
            
            VStack(alignment:.leading, spacing: 6){
            Text("Deskripsi")
                    .font(.system(.footnote, design: .rounded)).bold()
                    .scaledFont(name: "", size: 14)
                    .minimumScaleFactor(0.01)
                    .lineLimit(1)
                    .foregroundColor(.black)
            Text(project2.description)
                    .font(.system(.caption, design: .rounded))
                    .scaledFont(name: "", size: 12)
                    .minimumScaleFactor(0.01)
                    .lineLimit(1)
                .foregroundColor(.black)
            }
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

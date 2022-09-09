//
//  EmptyListView.swift
//  UMKM
//
//  Created by Cyntya Rahma Dita on 09/09/22.
//

import SwiftUI

struct EmptyListView: View {
    var body: some View {
        VStack(alignment:.center,spacing: 80){
            VStack(alignment:.center, spacing: 10){
                Text("Wah belum ada yang daftar")
                    .font(.system(.footnote, design: .rounded)).bold()
                    .scaledFont(name: "", size: 18)
                    .minimumScaleFactor(0.01)
                    .lineLimit(1)
                    .foregroundColor(.black)
                Text("Yuk ajak teman komunitasmu untuk bergabung!")
                    .font(.system(.footnote, design: .rounded))
                    .scaledFont(name: "", size: 14)
                    .minimumScaleFactor(0.01)
                    .lineLimit(1)
                    .foregroundColor(.black)
                }
                .accessibilityElement(children: .combine)
                .accessibilityLabel("Wah belum ada yang daftar. yuk ajak teman komunitasmu untuk bergabung!")
            Image("ajakTeman")
                .resizable()
                .scaledToFit()
                .frame(height:250)
                .accessibilityHidden(true)
            }.padding()
                .frame(width: UIScreen.main.bounds.width/1.1, alignment:.center)
                .background(.white)
                .cornerRadius(16)
    }
}

struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView()
    }
}

//
//  DetailProjectCardView.swift
//  UMKM
//
//  Created by Trevincen Tambunan on 24/08/22.
//

import SwiftUI

struct DetailProjectCardView: View {
    var body: some View {
        VStack(alignment:.leading,spacing: 15){
            Group{
                HStack{
                    Image("location").resizable().scaledToFit().frame(width: 20, height: 20)
                    Text("Lokasi : ").font(.system(size: 12, weight: .medium, design: .default))
                    Text("Basecamp").font(.system(size: 12, weight: .medium, design: .default))
                }
                HStack{
                    Image(systemName: "calendar").resizable().scaledToFit().frame(width: 20, height: 20)
                    Text("Waktu : ").font(.system(size: 12, weight: .medium, design: .default))
                    Text("21 Aug 22")
                    Text("|")
                    Text("8.00 - 10.00 AM")
                }.font(.system(size: 12, weight: .medium, design: .default))
                HStack{
                    Image(systemName: "person").resizable().scaledToFit().frame(width: 20, height: 20)
                    Text("Ideator : ").font(.system(size: 12, weight: .medium, design: .default))
                    Text("Yoyok").font(.system(size: 12, weight: .medium, design: .default))
                }
            }
            Text("Tujuan :").font(.system(size: 17, weight: .bold, design: .default))
            Text("Basecamp jadi besih mengkilat").font(.system(size: 12, weight: .regular, design: .default))
            Text("Deskripsi :").font(.system(size: 17, weight: .bold, design: .default))
            Text("Basecamp jadi besih mengkilat. Butuh minimal 5 orang buat ikutan nih.").font(.system(size: 12, weight: .regular, design: .default)).fixedSize(horizontal: false, vertical: true)
            HStack{
                Image(systemName: "person.circle.fill")
                Text("6 Member telah bergabung").font(.system(size: 12, weight: .regular, design: .default))
            }
        }.padding()
            .frame(width: UIScreen.main.bounds.width/1.2, alignment:.leading)
            .background(.white)
            .cornerRadius(16)
    }
}

struct DetailProjectCardView_Previews: PreviewProvider {
    static var previews: some View {
        DetailProjectCardView()
    }
}

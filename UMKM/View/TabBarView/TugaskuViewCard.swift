//
//  TugaskuViewCard.swift
//  UMKM
//
//  Created by Trevincen Tambunan on 13/09/22.
//

import SwiftUI

struct TugaskuCardView: View {
    @Binding var task:TaskViewModel
    
    var body: some View {
        VStack{
            HStack{
                Image("Oval")
                    .resizable()
                    .scaledToFit()
                    .frame(height:24)
                Text("Sapu Lantai")
                    .font(.system(.title3, design: .rounded).bold())
                    .minimumScaleFactor(0.01)
                    .scaledFont(name: "", size: 24)
                    .lineLimit(1)
                    .foregroundColor(.black)
                Spacer()
            }
            HStack{
                Text("Proyek Bersih Bersih Basecamp")
                    .font(.system(.subheadline, design: .rounded))
                    .scaledFont(name: "", size: 14)
                    .minimumScaleFactor(0.01)
                    .lineLimit(1)
                    .foregroundColor(.black)
                    .padding(.leading, 32)
                
                Spacer()
            }
          
            
        }.padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
            .frame(width: UIScreen.main.bounds.width/1.1, alignment:.leading)
            .background(.white)
            .cornerRadius(15)
            .minimumScaleFactor(0.01)
            .padding(.top, 16)

    }
}

struct TugaskuViewCard_Previews: PreviewProvider {
    static var previews: some View {
        TugaskuCardView()
    }
}

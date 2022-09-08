//
//  OnboardingView.swift
//  UMKM
//
//  Created by Trevincen Tambunan on 07/09/22.
//

import SwiftUI

struct OnboardingView: View {
    @State var komunitas = ""
    @State var divisi = ""
    @State var pengalaman = ""
    var placeholder = "Divisi"
    @State var dropDownList = ["Humas", "Sekertariat"]
    
    let firstName = UserDefaults.standard.object(forKey: "firstName") as? String
    let lastName = UserDefaults.standard.object(forKey: "lastName") as? String
    
    var body: some View {
        VStack(spacing:10) {
            HStack {
                Text("Halo")
                Text("\(firstName!) \(lastName!)").foregroundColor(.yellow)
            }.font(.system(size: 34, weight: .bold, design: .default))
            Text("Cerita dikit yuk!").font(.system(size: 34, weight: .regular, design: .default))
            //            Spacer()
            HStack{
                Image(systemName: "house").foregroundColor(.blue)
                TextField("Komunitas", text: $komunitas)
            }
            Divider()
            HStack{
                Image(systemName: "person.2").foregroundColor(.blue)
                Menu {
                    ForEach(dropDownList, id: \.self){ divisi in
                        Button(divisi) {
                            self.divisi = divisi
                        }
                    }
                } label: {
                    VStack(spacing: 5){
                        HStack{
                            Text(divisi.isEmpty ? placeholder : divisi)
                                .foregroundColor(.black)
//                                .foregroundColor(divisi.isEmpty ? .gray : .black)
                                .opacity(divisi.isEmpty ? 0.3 : 1)
                            Spacer()
                        }
                    }
                }
            }
            
            Divider()
            HStack(alignment:.top){
                Image(systemName: "person.fill.questionmark").foregroundColor(.blue).padding(.vertical,3)
                Spacer()
                VStack(alignment:.leading) {
                    Text("Tentang Kamu").font(.system(size: 18, weight: .regular, design: .rounded)).opacity(0.3)
                    Text("Ceritakan pengalaman atau keahlian kamu, sampaikan juga hal-hal yang menurut kamu menarik atau penting").font(.system(size: 14, weight: .regular, design: .rounded)).opacity(0.3)
                    ZStack {
                        TextEditor(text: $pengalaman)
                        Text(pengalaman).opacity(0).padding(8)
                    }
                }
            }
            Divider()
            Spacer()
        }.padding()
            .interactiveDismissDisabled(true)
            
    }
}

//struct OnboardingView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingView()
//    }
//}

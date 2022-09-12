//
//  OnboardingView.swift
//  UMKM
//
//  Created by Trevincen Tambunan on 07/09/22.
//

import SwiftUI

struct OnboardingView: View {
    
    @State var containerHeight:CGFloat = 0
    
    @State var komunitas = ""
    @State var divisi = ""
    @State var pengalaman = ""
    var placeholder = "Divisi"
    @State var dropDownList = ["Humas", "Sekertariat", "Sosmed", "Lainnya"]
    
    let firstName = UserDefaults.standard.object(forKey: "firstName") as? String
    let lastName = UserDefaults.standard.object(forKey: "lastName") as? String
    
    var body: some View {
        VStack(spacing:10) {
            Group{
                HStack {
                    Text("Halo")
                    Text("\(firstName!) \(lastName!)").foregroundColor(.yellow)
                }.font(.system(size: 34, weight: .bold, design: .default))
                Text("Cerita dikit yuk!").font(.system(size: 34, weight: .regular, design: .default))
                //            Spacer()
            }
                .accessibilityElement(children: .combine)
                .accessibilityLabel("Halo \(firstName!) \(lastName!), Cerita dikit yuk!")
            HStack{
                Image(systemName: "house").foregroundColor(.blue)
                    .accessibilityHidden(true)
                TextField("Komunitas", text: $komunitas)
            }.accessibilityElement(children: .combine)
                .accessibilityLabel("Tulis nama komunitasmu")
            Divider()
            HStack{
                Image(systemName: "person.2").foregroundColor(.blue)
                    .accessibilityHidden(true)
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
                Image(systemName: "person.fill.questionmark").foregroundColor(.blue).padding(.vertical,10)
                    .accessibilityHidden(true)
                Spacer()
                AutoSizingTF(hint: "Ceritakan pengalaman atau keahlian kamu, sampaikan juga hal-hal yang menurut kamu menarik atau penting", text: $pengalaman, containerHeight: $containerHeight)
                    .frame(height: containerHeight <= 300 ? containerHeight : 300).background(.white).cornerRadius(10)
//                    .padding()
            }.accessibilityElement(children: .combine)
                .accessibilityLabel("Ceritakan pengalaman atau keahlian kamu, sampaikan juga hal-hal yang menurut kamu menarik atau penting")
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

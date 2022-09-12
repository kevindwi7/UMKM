//
//  OnboardingView.swift
//  UMKM
//
//  Created by Trevincen Tambunan on 07/09/22.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject var vm:MainViewModel
    @StateObject var hm:HomeViewModel
    let userID = UserDefaults.standard.object(forKey: "userID") as? String
    @State var containerHeight:CGFloat = 0
    
    @State var komunitas: String = ""
    @State var divisi: String = ""
    @State var pengalaman: String = ""
    @Binding var updateUser: UserViewModel
    
    var placeholder = "Divisi"
    @State var dropDownList = ["Humas", "Sekertariat", "Sosmed", "Lainnya"]
    
    @Binding var isActive:Bool
    
    let firstName = UserDefaults.standard.object(forKey: "firstName") as? String
    let lastName = UserDefaults.standard.object(forKey: "lastName") as? String
    
    var body: some View {
        NavigationView {
            VStack(spacing:10) {
                Group{
                    HStack {
                        Text("Halo")
                        Text("\(firstName!) \(lastName!)").foregroundColor(.yellow).lineLimit(1)
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
                
                Button(action: {
                    hm.updateUserOnboarding(users: updateUser, komunitas: komunitas, divisi: divisi, pengalaman: pengalaman, isFirstTime: false){
                        self.isActive = false
                    }
                }, label: {
                    Text("Save")
                })
            }.padding()
                .interactiveDismissDisabled(true)
                .navigationTitle((updateUser.firstName) + (updateUser.lastName))
                .navigationBarTitleDisplayMode(.inline)
                
        }
        }
    
        
    }


//struct OnboardingView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingView()
//    }
//}

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
    
    @State var komunitas: String = ""
    @State var divisi: String = ""
    @State var pengalaman: String = ""
    @Binding var updateUser: UserViewModel
    
    var placeholder = "Divisi"
    @State var dropDownList = ["Humas", "Sekertariat"]
    
    @Binding var isActive:Bool
    
    let firstName = UserDefaults.standard.object(forKey: "firstName") as? String
    let lastName = UserDefaults.standard.object(forKey: "lastName") as? String
    
    var body: some View {
        LoadingView(isShowing: $vm.isLoadingUserProfile){
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
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    //                        if(project.hostId == userID) {
                    Button(action: {
                        hm.updateUserOnboarding(users: updateUser, komunitas: komunitas,divisi: divisi,pengalaman: pengalaman)
//                        hm.updateUserOnboarding(users: updateUser, komunitas: komunitas, divisi: divisi, pengalaman: pengalaman, isFirstTime: false)
                        
//                        vm.createUserFirstTime(userID: userID!, isFirstTime: false)
                    }){
                        Text("Simpan").foregroundColor(.white)
                    }
                    //                            .accessibilityLabel("Hapus \(project.projectName)")
                    //                        }
                }
            }
            .padding()
            .interactiveDismissDisabled(true)
        }
    
        
    }
}

//struct OnboardingView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingView()
//    }
//}

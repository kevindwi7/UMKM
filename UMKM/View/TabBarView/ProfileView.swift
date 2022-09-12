//
//  ProfileView.swift
//  UMKM
//
//  Created by Kevin  Dwi on 24/08/22.
//

import SwiftUI

struct ProfileView: View {
    
//    @StateObject var vm:HomeViewModel
//    
//    init(vm: HomeViewModel) {
//        _vm = StateObject(wrappedValue: vm)
//    }
    
    var body: some View {
        ZStack{
            Color(UIColor.systemGray6).ignoresSafeArea()
            VStack{
                ZStack(alignment: .topTrailing){
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 90)
                        .foregroundColor(.black)
                        .padding()
                        .accessibilityLabel("foto profile user")
                        .opacity(0.5)
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 17, height: 16)
                        .foregroundColor(.cyan)
                        .accessibilityLabel("edit gambar profil")

                }
                HStack(alignment: .center, spacing: 20){
                    VStack{
                        Text("Tugas yang harus")
                            .font(.system(size: 10, weight: .regular, design: .rounded))
                        Text("dikerjakan")
                            .font(.system(size: 10, weight: .regular, design: .rounded))
                        Text("50")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(.cyan)
                        Text("Tugas")
                            .font(.system(size: 10, weight: .regular, design: .rounded))
                    }
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width/3.7, height: 91)
                    .foregroundColor(.black)
                    .background( RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.white))
                    .accessibilityLabel("")
                    
                    VStack{
                        Text("Dalam Pengerjaan")
                            .font(.system(size: 10, weight: .regular, design: .rounded))
                        Spacer(minLength: 2)
                        Text("4")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(.cyan)
                        Text("Tugas")
                            .font(.system(size: 10, weight: .regular, design: .rounded))
                    }
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width/3.7, height: 91)
                    .foregroundColor(.black)
                    .background( RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.white))
                    .accessibilityLabel("")
                    
                    VStack{
                        Text("Selesai")
                            .font(.system(size: 10, weight: .regular, design: .rounded))
                        Spacer(minLength: 1)
                        Text("90")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(.cyan)
                        Text("Tugas")
                            .font(.system(size: 10, weight: .regular, design: .rounded))
                    }
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width/3.7, height: 91)
                    .foregroundColor(.black)
                    .background( RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.white))
                    .accessibilityLabel("")
                }
                VStack(alignment: .leading, spacing: 15){
                    HStack(spacing: 6){
                        VStack(alignment: .leading, spacing: 6){
                            Text("Nama").font(.system( .caption, design: .rounded))
                            Text("Tania Wilona").font(.system(.headline, design: .rounded))
                        }.padding(.leading)
                        Spacer()
                        VStack(alignment: .trailing){
                            Image(systemName: "square.and.pencil")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 17, height: 16)
                                .foregroundColor(.cyan)
                                .accessibilityLabel("edit gambar profil")
                        }
                    }
                }
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width/1.1, height: 51, alignment: .leading)
                .foregroundColor(.black)
                .background( RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.white))
                
                .accessibilityLabel("")
            }
                
            
        }
//        .onAppear{
//            vm.fetchAllUser()
////            print(123)
//        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

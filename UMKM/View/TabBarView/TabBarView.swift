//
//  TabBarView.swift
//  UMKM
//
//  Created by Kevin  Dwi on 24/08/22.
//

import SwiftUI
import CloudKit

struct TabBarView: View {
    let test = Color("F2F2F7")
//    init() {
//        UITabBar.appearance().backgroundColor = UIColor(.white)
//        }
    var body: some View {
        TabView{
            HomeView(vm: HomeViewModel(container: CKContainer.default()))
                .tabItem{
                    Label("Explore", systemImage: "person.3")
                }
            TugaskuView(vm: HomeViewModel(container: CKContainer.default()))
                .tabItem{
                    Label("Tugasku", systemImage: "person.3")
                }
            ProfileView()
                .tabItem{
                    Label("Profile", systemImage: "person")
                    
                }
        }
     
       
}
//
//struct TabBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabBarView()
//    }
}

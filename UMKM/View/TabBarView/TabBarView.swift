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
            HomeView(vm: HomeViewModel(container: CKContainer.default()), mvm: MainViewModel(container: CKContainer.default()), nvm: notificationViewModel())
                .tabItem{
                    Label("Explore", systemImage: "person.3.fill")
                }
            TugaskuView(vm: HomeViewModel(container: CKContainer.default()), mvm: MainViewModel(container: CKContainer.default()))
                .tabItem{
                    Label("Tugasku", systemImage: "list.bullet")
                }
            ProfileView(nvm: notificationViewModel())
                .tabItem{
                    Label("Profile", systemImage: "person.fill")
                    
                }
        }
     
       
}
//
//struct TabBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabBarView()
//    }
}

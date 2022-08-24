//
//  TabBarView.swift
//  UMKM
//
//  Created by Kevin  Dwi on 24/08/22.
//

import SwiftUI
import CloudKit

struct TabBarView: View {
    var body: some View {
        TabView{
            HomeView()
                .tabItem{
                    Label("Explore", systemImage: "person.3")
                }
            TugaskuView()
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

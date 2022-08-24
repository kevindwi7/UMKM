//
//  HomeView.swift
//  UMKM
//
//  Created by Kevin  Dwi on 24/08/22.
//

import SwiftUI

struct HomeView: View {
    
    @State var isShowingDetailProjectView = false
    
    var body: some View {
        NavigationView{
            ZStack{
                NavigationLink(destination: DetailProjectView(), isActive: $isShowingDetailProjectView) { EmptyView() }
                ScrollView{
                    ForEach(0...10, id: \.self){ project in
                        ProjectCardView(isShowingDetailProjectView: self.$isShowingDetailProjectView)
                        
                    }.padding()
                }
                .navigationTitle("Proyek")
                .frame(width: UIScreen.main.bounds.width)
                .background(Color.primaryGray)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    NavigationLink(destination: HomeView()) {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

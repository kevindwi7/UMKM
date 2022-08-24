//
//  HomeView.swift
//  UMKM
//
//  Created by Kevin  Dwi on 24/08/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView{
            ScrollView{
                ForEach(0...10, id: \.self){ project in
                    ProjectCardView()
                    
                }.padding()
            }
            .navigationTitle("Proyek")
                .frame(width: UIScreen.main.bounds.width)
                .background(Color.primaryGray)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button {
                        print(123)
                    } label: {
                        Image(systemName: "plus.circle.fill")
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

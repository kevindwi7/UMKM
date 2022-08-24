//
//  DashboardView.swift
//  UMKM
//
//  Created by Trevincen Tambunan on 24/08/22.
//

import SwiftUI

struct DashboardView: View {
    
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

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}

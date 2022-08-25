//
//  HomeView.swift
//  UMKM
//
//  Created by Kevin  Dwi on 24/08/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject var vm:HomeViewModel
    @State var isActive = false
    
    init(vm: HomeViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical){
                VStack(alignment: .leading){
                    ForEach($vm.projects, id: \.id){ $project in
                        ProjectCardView(vm: self.vm, project: $project)
                    }.padding(.vertical, 6)
                }
                
            }
            .frame(width: UIScreen.main.bounds.width)
            .background(Color.primaryGray)
            .navigationTitle("Proyek")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                    Button {
                        self.isActive = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }.background(NavigationLink(destination: CreateProjectView(), isActive: $isActive, label: {
                        EmptyView()
                    })
                                 )
                }
                .onAppear {
                    //                vm.fetchUserID()
                    vm.fetchProject()
                }
                .onReceive(vm.objectWillChange) { _ in
                    vm.fetchProject()
                }
            }
        }
    }


//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}

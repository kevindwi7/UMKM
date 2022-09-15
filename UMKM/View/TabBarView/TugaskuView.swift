//
//  TugaskuView.swift
//  UMKM
//
//  Created by Kevin  Dwi on 24/08/22.
//

import SwiftUI

struct TugaskuView: View {
    
    @StateObject var vm:HomeViewModel
    @StateObject var mvm:MainViewModel
    
    @State var usersID = UserDefaults.standard.object(forKey: "userID") as? String
    
    init(vm: HomeViewModel, mvm: MainViewModel) {
        _vm = StateObject(wrappedValue: vm)
        _mvm = StateObject(wrappedValue: mvm)
    }
    var body: some View {
        NavigationView{
            ZStack {
                Color(UIColor.systemGray6)
                ScrollView{
                    VStack(alignment: .leading){
                        ForEach($mvm.userTasks, id: \.self){$task in
                                TugaskuCardView(task: $task)
//                                EmptyTugasView()
                            
                            
                        }
                    }
                }
//                .navigationBarTitle(Text("Tugasku").font(.largeTitle).bold(), displayMode: .inline).accentColor(Color(.label))
            }
            .navigationTitle("Tugasku")
            .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(.stack)
            .onAppear {
                let appearance = UINavigationBarAppearance()
                appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
                appearance.backgroundColor = UIColor(Color.cyan
                                                     //                            .opacity(0.2)
                )
                appearance.titleTextAttributes = [NSAttributedString.Key
                    .foregroundColor : UIColor.white]
                
                UINavigationBar.appearance().scrollEdgeAppearance = appearance
                mvm.fetchUserTasks(userID: usersID ?? "")
            }
    }
}



//struct TugaskuView_Previews: PreviewProvider {
//    static var previews: some View {
//        TugaskuView()
//    }
//}

//
//  TugaskuView.swift
//  UMKM
//
//  Created by Kevin  Dwi on 24/08/22.
//

import SwiftUI

struct TugaskuView: View {
    
    @StateObject var vm:HomeViewModel
    
    init(vm: HomeViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    var body: some View {
        NavigationView{
            ZStack {
                Color(UIColor.systemGray6)
                ScrollView{
                    VStack(alignment: .leading){
                        ForEach(1...5, id: \.self){_ in
//                            TugaskuCardView()
                        }
                    }
                }
//                .navigationBarTitle(Text("Tugasku").font(.largeTitle).bold(), displayMode: .inline).accentColor(Color(.label))
            }
            
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
                
            }
    }
}



//struct TugaskuView_Previews: PreviewProvider {
//    static var previews: some View {
//        TugaskuView()
//    }
//}

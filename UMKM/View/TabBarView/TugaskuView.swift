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
                            VStack{
                                HStack{
                                    Image("Oval")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height:24)
                                    Text("Sapu Lantai")
                                        .font(.system(.title3, design: .rounded).bold())
                                        .minimumScaleFactor(0.01)
                                        .scaledFont(name: "", size: 24)
                                        .lineLimit(1)
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                                HStack{
                                    Text("Proyek Bersih Bersih Basecamp")
                                        .font(.system(.subheadline, design: .rounded))
                                        .scaledFont(name: "", size: 14)
                                        .minimumScaleFactor(0.01)
                                        .lineLimit(1)
                                        .foregroundColor(.black)
                                        .padding(.leading, 32)
                                    
                                    Spacer()
                                }
                              
                                
                            }.padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                                .frame(width: UIScreen.main.bounds.width/1.1, alignment:.leading)
                                .background(.white)
                                .cornerRadius(15)
                                .minimumScaleFactor(0.01)
                                .padding(.top, 16)
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

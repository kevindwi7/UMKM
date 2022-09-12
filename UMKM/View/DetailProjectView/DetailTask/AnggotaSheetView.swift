//
//  AnggotaSheetView.swift
//  UMKM
//
//  Created by Trevincen Tambunan on 06/09/22.
//

import SwiftUI

struct AnggotaSheetView: View {
    
    @StateObject var vm:HomeViewModel
    @Environment(\.dismiss) var dismiss
    @State var test:Int = 5
    @State var status = ""
    
    init(vm: HomeViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationView {
            if(test == 0){
                EmptyListView()
                    .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height)
                    .background(SwiftUI.Color.primaryGray)
                    .padding()
                    .navigationTitle("Anggota")
                    .toolbar(content: {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                dismiss()
                                HapticManager.instance.notification(type: .warning)
                            } label: {
                                Text("Cancel").accessibilityLabel("Kembali")
                            }
                            
                        }
                        
                    }
                    )
                    .navigationBarTitleDisplayMode(.inline)
            }else{
                VStack(alignment:.leading,spacing: 10) {
                    Text("Pilih anggota untuk tugas").font(.system(size: 14, weight: .regular, design: .default)).padding(.horizontal).padding(.top)
                    Text("Pel Lantai").font(.system(size: 14, weight: .regular, design: .default)).padding(.horizontal)
                    List {
                        ForEach(0..<test, id: \.self) { anggota in
//                            var status = ""
                            VStack {
                                HStack (spacing:30){
                                    Text("ASd").font(.system(size: 14, weight: .medium, design: .rounded))
                                    Spacer()
                                    Button {
                                        self.status = "Accept"
                                        print(status)
                                    } label: {
                                        Image(systemName: "person.fill.checkmark").opacity(0.5).foregroundColor(self.status=="Accept" ? .blue : .primary)

                                    }
                                    Button {
                                        self.status = "Decline"
                                        print("Decline")
                                    } label: {
                                        Image(systemName: "person.fill.xmark").opacity(0.5).foregroundColor(self.status=="Decline" ? .blue : .primary)
                                    }
    
                                }.buttonStyle(PlainButtonStyle())
                            }
                            
                        }
                    }
                    .cornerRadius(10)
                    .listStyle(.automatic)
                }
                .frame(width: UIScreen.main.bounds.width)
                .background(SwiftUI.Color.primaryGray)
                .navigationTitle("Anggota")
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                            HapticManager.instance.notification(type: .warning)
                        } label: {
                            Text("Cancel").accessibilityLabel("Kembali")
                        }
                        
                    }
                    
                }
                )
                .navigationBarTitleDisplayMode(.inline)
            }
            
            
        }
        .onAppear{
            vm.fetchAllUser()
        }
    }
}

//struct AnggotaSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        AnggotaSheetView()
//    }
//}

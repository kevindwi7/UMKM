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
    
    init(vm: HomeViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment:.leading,spacing: 10) {
                Text("Pilih anggota untuk tugas").font(.system(size: 14, weight: .regular, design: .default)).padding(.horizontal)
                Text("Pel Lantai").font(.system(size: 14, weight: .regular, design: .default)).padding(.horizontal)
                List(0..<30) {_ in
                    VStack {
                        HStack {
                            Text("ASd").font(.system(size: 14, weight: .medium, design: .rounded))
                            Spacer()
                            Image(systemName: "person.fill.checkmark").opacity(0.5)
                            Image(systemName: "person.fill.xmark").opacity(0.5)
                        }
                    }
                }
                .cornerRadius(10)
                .padding()
                .listStyle(.plain)
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

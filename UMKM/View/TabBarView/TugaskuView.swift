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
        VStack {
            Image(systemName: "person.fill.checkmark").opacity(0.5)
        }.onAppear{
            vm.fetchAllUser()
//            print(123)
        }
    }
}

//struct TugaskuView_Previews: PreviewProvider {
//    static var previews: some View {
//        TugaskuView()
//    }
//}

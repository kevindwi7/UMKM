//
//  ProfileView.swift
//  UMKM
//
//  Created by Kevin  Dwi on 24/08/22.
//

import SwiftUI

struct ProfileView: View {
    
    @State var viewModel = notificationViewModel()
    var body: some View {
        Button {
            viewModel.requestNotificationPermission(){message in
                viewModel.subscribeToNotifications()
            }
        } label: {
            Text("Get Notification")
        }

    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

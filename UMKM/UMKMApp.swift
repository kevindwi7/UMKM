//
//  UMKMApp.swift
//  UMKM
//
//  Created by Kevin  Dwi on 24/08/22.
//

import SwiftUI
import AuthenticationServices

import CloudKit

@main
struct UMKMApp: App {
    @State var isListRoomView = false
    var body: some Scene {
        WindowGroup {
            TabBarView()
        }
    }
}

//
//  EventiLatteApp.swift
//  EventiLatte
//
//  Created by Maanas Manoj on 8/27/23.
//

import SwiftUI
import Firebase

@main
struct EventiLatteApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

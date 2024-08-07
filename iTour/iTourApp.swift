//
//  iTourApp.swift
//  iTour
//
//  Created by Mayur Vaity on 07/08/24.
//

import SwiftUI
import SwiftData

@main
struct iTourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Destination.self) //it tells swiftdata to create Destination obj in swiftdata (if not already created) and load it for app to access it 
    }
}

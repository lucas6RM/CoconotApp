//
//  coconot_appApp.swift
//  coconot_app
//
//  Created by lucas mercier on 16/10/2025.
//

import SwiftUI
import SwiftData

@main
struct coconot_appApp: App {
    
    @AppStorage("isDarkModeEnabled") var isDarkMode = false

    var body: some Scene {
        WindowGroup {
            LaunchingView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}

//
//  DecaffeineApp.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 29/1/2023.
//

import SwiftUI
import FirebaseCore

@main
struct DecaffeineApp: App {
    @AppStorage("log_Status") private var logStatus : Bool = false

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            if logStatus {
                ContentView()
            } else {
                LoginView()
            }
        }
    }
}

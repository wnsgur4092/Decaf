//
//  DecaffeineApp.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 29/1/2023.
//

import SwiftUI
import MijickPopupView


@main
struct DecaffeineApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .implementPopupView(config: configurePopup)
        }
    }
}

private extension DecaffeineApp {
    func configurePopup(_ config: GlobalConfig) -> GlobalConfig {
        config
            .centre { $0
                .tapOutsideToDismiss(false)
            }
    }
}

//
//  DecaffeineApp.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 29/1/2023.
//

import SwiftUI


@main
struct DecaffeineApp: App {
    @AppStorage("isOnboarding") var isOnboarding : Bool = true
    
    var body: some Scene {
        
        WindowGroup {
            if isOnboarding == true {
                OnBoardingView()
            } else {
                ContentView()
            }
        }
        
    }
}

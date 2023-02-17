//
//  ContentView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 29/1/2023.
//

import SwiftUI

struct ContentView: View {
    //MARK: - PROPERTIES
    @State var selectedTab = 0
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(homeVM: HomeViewModel())
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }

            
            ArchiveView()
                .tabItem {
                    Image(systemName: "book")
                    Text("Archive")
                }
            
            SettingView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Setting")
                }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

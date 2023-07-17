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
        HomeView()
//            .tabItem {
//                Image(systemName: "house")
//                Text("Today")
//            }
            .environmentObject(ShareDataViewModel())
        //        TabView(selection: $selectedTab) {
        //
        //
        //
        //
        //            ArchiveView()
        //                .tabItem {
        //                    Image(systemName: "calendar")
        //                    Text("Monthly")
        //                }
        //        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

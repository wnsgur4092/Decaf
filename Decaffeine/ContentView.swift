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
            DashBoardView(viewModel: BeverageViewModel())
                .tabItem {
                    Image(systemName: "house")
                    Text("Today")
                }
                .tag(0)  // Corresponds to the selectedTab state
            
            BeverageListView(viewModel: BeverageViewModel())
                .tabItem{
                    Image(systemName: "plus.circle")
                }
                .tag(1)
            
            Text("Hi")
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Monthly")
                }
                .tag(2)  // Corresponds to the selectedTab state
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

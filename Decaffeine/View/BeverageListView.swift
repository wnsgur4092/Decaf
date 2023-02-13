//
//  BeverageListView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 13/2/2023.
//

import SwiftUI

struct BeverageListView: View {
    var body: some View {
        NavigationView {
            VStack{
                
                HStack(spacing: 60){
                    Text("HOT")
                    Text("COLD")
                    
                    Spacer()
                }
                
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 20)]) {
                    ForEach(0..<10) { index in
                        Text("Item \(index)")
                        
                    }
                }
                
                
                
            }
            
            .navigationTitle("Add New Caffeine")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Image(systemName: "xmark"))
        }
        
        
        
        
    }
}

struct BeverageListView_Previews: PreviewProvider {
    static var previews: some View {
        BeverageListView()
    }
}

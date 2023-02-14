//
//  BeverageListView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 13/2/2023.
//

import SwiftUI
import UIKit
import SegmentedPicker

struct BeverageListView: View {
    //MARK: - PROPERTEIS
 

    //MARK: - INIT
    init() {
        UINavigationBar.appearance().backgroundColor = UIColor(Color("mainColor"))
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    let titles: [String] = ["HOT", "COLD"]
    @State var selectedIndex: Int?
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            VStack{
                HStack{
                    categoriesList
                    Spacer()
                }
                .padding(.vertical, 20)
                
                ScrollView{
                    Text("Jun")
                }
            }
            .padding(.horizontal, 32)
            
            .navigationTitle("Add New Caffeine")
            .navigationBarTitleDisplayMode(.inline)
        }
        
        
    }
    
    //MARK: - COMPONENTS
    
    fileprivate var categoriesList : some View {
        SegmentedPicker(
            titles,
            selectedIndex: Binding(
                get: { selectedIndex },
                set: { selectedIndex = $0 }),
            selectionAlignment: .bottom,
            content: { item, isSelected in
                Text(item)
                    .foregroundColor(isSelected ? Color("mainColor") : Color.gray )
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
            },
            selection: {
                VStack(spacing: 20) {
                    Spacer()
                    Color("mainColor").frame(height: 1)
                }
            })
            .onAppear {
                selectedIndex = 0
            }
            .animation(.easeInOut(duration: 0.3))
    }
    
}
struct BeverageListView_Previews: PreviewProvider {
    static var previews: some View {
        BeverageListView()
    }
}

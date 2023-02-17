//
//  BeverageListView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 13/2/2023.
//

import SwiftUI
import UIKit
import SegmentedPicker

struct BeverageAddView: View {
    //MARK: - PROPERTEIS
    @Environment(\.presentationMode) var presentationMode
    @StateObject var beverageAddvm : BeverageAddViewModel
    
    
    //CATEOGRY
    @State var selectedCoffee = false
    let titles: [String] = ["HOT", "COLD"]
    @State var selectedIndex: Int = 0
    
    var selectedCategory: BeverageCategory {
        return selectedIndex == 0 ? .hot : .cold
    }
    
    var selectedBeverages: [Beverage] {
        return Beverage.beverageList.filter { $0.category == selectedCategory }
    }
    
    //MARK: - INIT
    //    init() {
    //        //NavigationBar Background & Foreground Color
    //        UINavigationBar.appearance().backgroundColor = UIColor(Color("mainColor"))
    //        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    //    }
    
    
    let layout : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            VStack{
                HStack{
                    categoriesList
                    Spacer()
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 20)
                
                //SCROLLVIEW
                
                HStack(alignment:.bottom){
                    ScrollView{
                        //COFFEE LIST
                        LazyVGrid(columns: layout) {
                            ForEach(selectedBeverages) { beverage in
                                Text(beverage.beverageName)
                            }
                        }
                    }
                }
                .padding(.bottom, 28)
                
                Spacer()
                
                //BUTTON
                HStack{
                    Button {
                        print("Back Button tapped")
                    } label: {
                        Text("Back")
                    }
                    .frame(maxWidth: 80, maxHeight: 40)
                    .buttonStyle(SecondaryButtonStyle())
                    
                    Spacer()
                    
                    Button {
                        print("Next button tapped")
                    } label: {
                        Text("Next")
                    }
                    .frame(maxWidth: 80, maxHeight: 40)
                    .buttonStyle(DisableButtonStyle())
                    
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 32)
                
                
                
                
                
                
                
                
            }
            
            
            .navigationTitle("Add New Caffeine")
            .navigationBarTitleDisplayMode(.inline)
            
        }
        
    }
    
    
    
    //MARK: - COMPONENTS
    //    fileprivate var beverageCategory : some View {
    //        HStack(spacing: 18) {
    //            ForEach(beverageCategory.)
    //        }
    //    }
    
    
    fileprivate var categoriesList : some View {
        SegmentedPicker(
            titles,
            selectedIndex: Binding(
                get: { selectedIndex },
                set: { selectedIndex = $0! }
            ),
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
        .animation(.easeInOut(duration: 0.3))
    }
    
    fileprivate var coffeeList : some View {
        EmptyView()
    }
    
}
struct BeverageListView_Previews: PreviewProvider {
    static var previews: some View {
        BeverageAddView(beverageAddvm: BeverageAddViewModel(isPresented: .constant(false), coffees: .constant([])))
    }
}

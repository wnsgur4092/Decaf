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
        //NavigationBar Background & Foreground Color
        UINavigationBar.appearance().backgroundColor = UIColor(Color("mainColor"))
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    let titles: [String] = ["HOT", "COLD"]
    @State var selectedIndex: Int?
    
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
                .padding(.vertical, 20)
                
                //SCROLLVIEW
                
                HStack(alignment:.bottom){
                    ScrollView{
                        //COFFEE LIST
                        LazyVGrid(columns: layout) {
                            //                            ForEach(1...8) {
                            //                                item in BeverageCell(framework: item)
                            ////                                    .onTapGesture {
                            ////                                        vm.isShowingDetail = true
                            ////                                        vm.selectedItem = item
                            ////                                    }
                            //                            }
                            BeverageCell(beverageImageName: "longblack", beverageName: "Longblack")
                            BeverageCell(beverageImageName: "longblack", beverageName: "Longblack")
                            BeverageCell(beverageImageName: "longblack", beverageName: "Longblack")
                            BeverageCell(beverageImageName: "longblack", beverageName: "Longblack")
                            BeverageCell(beverageImageName: "longblack", beverageName: "Longblack")
                            BeverageCell(beverageImageName: "longblack", beverageName: "Longblack")
                            BeverageCell(beverageImageName: "longblack", beverageName: "Longblack")
                            
                            
                            
                            
                        }
                    }
                }
                
                Spacer()
                
                //BUTTON
                HStack{
                    Button {
                        print("Cancel Button tapped")
                    } label: {
                        Text("Cancel")
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
                .padding(.top, 60)

                
                
                
                
                
                
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
    
    fileprivate var coffeeList : some View {
        EmptyView()
    }
    
}
struct BeverageListView_Previews: PreviewProvider {
    static var previews: some View {
        BeverageListView()
    }
}

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
    @State var selectedBeverageIndex : Int?
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
                //CATEOGRY
                HStack{
                    categoriesList
                    Spacer()
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 20)
                
                //SCROLLVIEW
                beverageListView
                    .padding(.bottom, 28)
                    .padding(.horizontal, 20)
                
                Spacer()
                
                //BUTTON
                buttonSection
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 40)
                
            }
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
    
    fileprivate var beverageListView : some View {
        HStack(alignment:.bottom){
            ScrollView{
                //COFFEE LIST
                LazyVGrid(columns: layout) {
                    ForEach(selectedBeverages.indices, id: \.self) { index in
                        // Add a tap gesture to the BeverageCell and update the selectedBeverageIndex
                        BeverageCell(beverageImageName: selectedBeverages[index].beverageImageName, beverageName: selectedBeverages[index].beverageName, index: index, selectedBeverageIndex: $selectedBeverageIndex)
                            .onTapGesture {
                                selectedBeverageIndex = index
                            }
                            
                    }
                }
            }
        }
    }
    
    fileprivate var buttonSection : some View {
        HStack{
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Back")
            }
            .frame(maxWidth: 80, maxHeight: 40)
            .buttonStyle(SecondaryButtonStyle())
            
            Spacer()
            
            NavigationLink {
                BeverageSettingView(vm: beverageAddvm)
            } label: {
                Text("Next")

            }
            .frame(maxWidth: 80, maxHeight: 40)
            .buttonStyle(DisableButtonStyle())
        }
    }
}

//MARK: - PREVIEW
struct BeverageListView_Previews: PreviewProvider {
    static var previews: some View {
        BeverageAddView(beverageAddvm: BeverageAddViewModel(isPresented: .constant(false), beverages: .constant([])))
    }
}

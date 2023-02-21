//
//  BeverageListView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 13/2/2023.
//

import SwiftUI
import UIKit
import SegmentedPicker

struct BeverageSelectView: View {
    //MARK: - PROPERTEIS
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: BeverageInputViewModel
    
   
    
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
    
    let layout : [GridItem] = [        GridItem(.flexible()),        GridItem(.flexible())    ]
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            VStack{
                //CATEOGRY
                HStack{
                    Spacer()
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 20)
                
                //SCROLLVIEW
                beverageLists
                    .padding(.bottom, 28)
                    .padding(.horizontal, 20)
                
                Spacer()
                
                //                BUTTON
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
//    fileprivate var beverageCateogry : some View {
//
//    }
    
    fileprivate var beverageLists : some View {
        HStack(alignment:.bottom){
            ScrollView{
                //COFFEE LIST
                LazyVGrid(columns: layout) {
                    ForEach(Beverage.beverageList.indices, id: \.self) { index in
                        let beverage = Beverage.beverageList[index]
                        Button(action: {
                            viewModel.updateBeverageName(name: beverage.beverageName)
                            viewModel.updateBeverageImageName(imageName: beverage.beverageImageName)
                            
                            
                            selectedBeverageIndex = index
                        }) {
                            BeverageCell(beverageImageName: beverage.beverageImageName, beverageName: beverage.beverageName, index: index, selectedBeverageIndex: $selectedBeverageIndex)
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
            
            NavigationLink(
                destination: BeverageSettingView(viewModel: viewModel),
                label: {
                    Text("Next")
                })
            .frame(maxWidth: 80, maxHeight: 40)
            .buttonStyle(ActiveButtonStyle())
            
       
        }
    }
}


//MARK: - PREVIEW
struct BeverageSelectView_Previews: PreviewProvider {
    static var previews: some View {
        BeverageSelectView(viewModel: BeverageInputViewModel(isPresented: .constant(false), selectedBeverages: .constant([])))
    }
}

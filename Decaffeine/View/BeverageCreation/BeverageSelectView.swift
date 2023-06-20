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
    @EnvironmentObject var sharedDataViewModel : ShareDataViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var isPresented : Bool
    
    @State private var selectedBeverageIndex : Int?
    @State private var selectedCategory: BeverageCategory = .hot
    @State private var selectedBeverages: [Beverage] = Beverage.beverageList.filter { $0.category == .hot }
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            VStack{
                //CATEOGRY
                beverageCateogry
                Divider()
                
                //SCROLLVIEW
                VStack {
                    beverageLists
                        .padding(.top, 10)
                    
                    Divider()
                }
                
                VStack{
                    buttonSection
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 20)
                    
                }
                .navigationTitle("Add New Caffeine")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
            }
        }
    }
    
    //MARK: - COMPONENTS
    fileprivate var beverageCateogry : some View {
        Picker("Category", selection: $selectedCategory) {
            ForEach(BeverageCategory.allCases, id: \.self) { category in
                Text(category.rawValue)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal)
        .onChange(of: selectedCategory) { value in
            selectedBeverages = Beverage.beverageList.filter { $0.category == selectedCategory }
        }
    }
    
    fileprivate var beverageLists : some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))]) {
                ForEach(selectedBeverages) { beverage in
                    Button(action: {
                        sharedDataViewModel.updateBeverageName(name: beverage.beverageName)
                        sharedDataViewModel.updateBeverageImageName(imageName: beverage.beverageImageName)
                        selectedBeverageIndex = beverage.id - 1
                    }) {
                        BeverageCell(beverageImageName: beverage.beverageImageName, beverageName: beverage.beverageName, index: beverage.id - 1, selectedBeverageIndex: $selectedBeverageIndex)
                    }
                }
            }
        }
    }
    
    
    fileprivate var buttonSection: some View {
        HStack {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Back")
            }
            .frame(maxWidth: 80, maxHeight: 40)
            .buttonStyle(SecondaryButtonStyle())
            
            Spacer()
            
            if selectedBeverageIndex != nil {
                NavigationLink(destination: {
                    BeverageSettingView(isPresented: $isPresented)
                }, label: {
                    Text("Next")
                })
                .frame(maxWidth: 80, maxHeight: 40)
                .buttonStyle(ActiveButtonStyle())
                
            } else {
                NavigationLink {
                    BeverageSettingView(isPresented: $isPresented)
                } label: {
                    Text("Next")
                }
                .frame(maxWidth: 80, maxHeight: 40)
                .buttonStyle(DisableButtonStyle())
                .disabled(true)
            }
            
//            NavigationLink {
//                BeverageSettingView(isPresented: $isPresented)
//            } label: {
//                Text("Next")
//            }
//            .frame(maxWidth: 80, maxHeight: 40)
//            .buttonStyle(ActiveButtonStyle())
//
        }
    }
}




//MARK: - PREVIEW
struct BeverageSelectView_Previews: PreviewProvider {
    static var previews: some View {
        BeverageSelectView(isPresented: .constant(false))
            .environmentObject(ShareDataViewModel())
    }
}

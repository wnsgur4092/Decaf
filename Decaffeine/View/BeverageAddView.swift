//
//  BeverageAddView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 29/1/2023.
//

import SwiftUI

struct BeverageAddView: View {
    //MARK: - PROPERTIES
    @ObservedObject var viewModel = BeverageViewModel()
    @State private var selectedType = BeverageType.coldCoffee
    
    let layout : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
    //MARK: - BODY
    var body: some View {
        VStack {
            Picker(selection: $selectedType, label: Text("Select a type")) {
                Text("Hot Coffee").tag(BeverageType.hotCoffee)
                Text("Cold Coffee").tag(BeverageType.coldCoffee)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            
            ScrollView {
                LazyVGrid(columns: layout) {
                    ForEach(self.viewModel.beverageList.filter { $0.beverageType == self.selectedType }) { beverage in
                        BeverageCardView(beverage: beverage)
                    }
                }
                .padding()
            }
            .padding([.top, .leading, .trailing], 12)
            
        }
    }
}


struct BeverageAddView_Previews: PreviewProvider {
    static var previews: some View {
        BeverageAddView()
    }
}

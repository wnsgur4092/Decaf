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
    @State private var selectedType = BeverageType.HotCoffee

    
    //MARK: - BODY
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: 15) {
                Text("What did you drink?")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal,25)
                
                //MARK: - PRODUCT TAB
                ScrollView(.horizontal,showsIndicators: false){
                    HStack(spacing: 18) {
                        ForEach(BeverageType.allCases, id:\.self) { type in
                            Button {
                                withAnimation {
                                    viewModel.beverageType = type
               
                                }
                            } label: {
                                Text(type.rawValue)
//                                    .font(.custom(customFont, size: 15))
                                    .fontWeight(.semibold)
                                    .foregroundColor(viewModel.beverageType == type ? Color.purple : Color.gray)
                                    .padding(.bottom, 10)
                                    .overlay(
                                        ZStack{
                                            if viewModel.beverageType == type {
                                                Capsule()
                                                    .fill(Color.purple.opacity(0.3))
                                                    .frame(height: 2)
                                    
                                            } else {
                                                Capsule()
                                                    .fill(Color.white)
                                                    .frame(height: 2)
                                            }
                                        }
                                        .padding(.horizontal, -5)
                                        , alignment: .bottom)
                            } //: BUTTON
                            
                        } //: LOOP
                    }//: HSTACK
                    .padding(.horizontal,25)
                } //: SCROLLVIEW
                .padding(.top, 28)
                
                //MARK: - PRODUCTS VIEW
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 25) {
                        ForEach(viewModel.filteredBeverages) { beverage in
                            BeverageCardView(beverage: beverage)
                        }
                    } //: HSTACK
                    .padding(.horizontal, 25)
                    .padding(.bottom)
                    .padding(.top, 80)
                } //: SCROLLVIEW
                .padding(.top, 30)
            } //: VSTACK
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onChange(of: viewModel.beverageType) { newValue in
            viewModel.filterProductByType(newValue)
        }
    }
}


struct BeverageAddView_Previews: PreviewProvider {
    static var previews: some View {
        BeverageAddView()
    }
}

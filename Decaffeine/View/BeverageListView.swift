//
//  BeverageListView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 2/10/2023.
//

import SwiftUI

struct BeverageListView: View {
    @Binding var showInputView: Bool
    @ObservedObject var viewModel = BeverageListViewModel()
    
    var body: some View {
        NavigationView{
            
            VStack {
                HStack {
                    Text("☕️ SELECT BEVERAGE")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                .padding()
                
                
                VStack(spacing: 20){
                    HStack{
                        FilterTag(title: BeverageListViewModel.Filter.coffee.rawValue, activeFilter: $viewModel.activeFilter)
                        FilterTag(title: BeverageListViewModel.Filter.tea.rawValue, activeFilter: $viewModel.activeFilter)
                        
                        Spacer()
                    }
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            HStack {
                                Text("CUSTOM BEVERAGE")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding(20)
                            .background(Color.red)
                            .cornerRadius(8)
                            
                            if viewModel.activeFilter == .coffee || viewModel.activeFilter == .all {
                                         ForEach(viewModel.coffeeTags, id: \.self) { tag in
                                             BeverageRow(title: tag.rawValue, showInputView: $showInputView)
                                         }
                                     }
                            
                            if viewModel.activeFilter == .tea || viewModel.activeFilter == .all {
                                    ForEach(viewModel.teaTags, id: \.self) { tag in
                                        BeverageRow(title: tag.rawValue, showInputView: $showInputView)
                                    }
                                }
                        }
                    }
                    
                }
                .padding(.horizontal, 20)
            }
        }
        
    }
}

struct FilterTag: View {
    var title: String
    @Binding var activeFilter: BeverageListViewModel.Filter
    
    var body: some View {
        Text(title)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.black))
            .onTapGesture {
                if title == BeverageListViewModel.Filter.coffee.rawValue {
                    activeFilter = .coffee
                } else if title == BeverageListViewModel.Filter.tea.rawValue {
                    activeFilter = .tea
                } else {
                    activeFilter = .all
                }
            }
    }
}

struct BeverageRow: View {
    var title: String
    @Binding var showInputView : Bool
    
    var body: some View {
        NavigationLink(destination: CoffeeInputView(beverageName: title, showInputView: $showInputView)) {
            HStack {
                Text(title)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .padding(20)
            .background(Color.onBackgroundTertiary)
            .cornerRadius(8)
        }
    }
}

#Preview {
    BeverageListView(showInputView: .constant(true))
}

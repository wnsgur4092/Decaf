//
//  DashBoardView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 2/10/2023.
//

import SwiftUI

struct DashBoardView: View {
    @ObservedObject var viewModel = BeverageViewModel()
    @State private var showInputView: Bool = false

    var body: some View {
        NavigationView {
            List(viewModel.allBeverages, id:\.generalName) { beverage in
                Text(beverage.generalName)
            }
            .navigationTitle("Dashboard")
            .navigationBarItems(trailing: Button("Add Coffee") {
                showInputView = true
            })
            .sheet(isPresented: $showInputView) {
                BeverageListView(showInputView: $showInputView)
            }
            .onAppear(perform: {
                viewModel.fetchAllBeverages()
            })
        }
    }
}


#Preview {
    DashBoardView(viewModel: BeverageViewModel())
}

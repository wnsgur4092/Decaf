//
//  DashBoardView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 2/10/2023.
//

import SwiftUI

struct DashBoardView: View {
    @ObservedObject var viewModel: BeverageViewModel
    @State private var showInputView: Bool = false
    
    var body: some View {
        ScrollView {
            // Contents of your ScrollView if any
            
            Spacer()
            
            Button(action: {
                showInputView.toggle()
            }) {
                Text("Add")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
        .sheet(isPresented: $showInputView) {
            BeverageListView()  // Assuming you have a view named BeverageListView to display the list of beverages
        }
    }
}


#Preview {
    DashBoardView(viewModel: BeverageViewModel())
}

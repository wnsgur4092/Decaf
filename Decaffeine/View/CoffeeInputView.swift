//
//  CoffeeInputView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 2/10/2023.
//

import SwiftUI

struct CoffeeInputView: View {
    @ObservedObject var viewModel = BeverageViewModel()
    @Binding var showInputView: Bool
    @State private var coffeeName: String = ""

    var body: some View {
        VStack {
            TextField("Enter coffee name", text: $coffeeName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Save") {
                viewModel.addCoffee(name: coffeeName)
                showInputView = false
            }
            .padding()
        }
        .navigationTitle("Coffee Input")
    }
}

#Preview {
    CoffeeInputView(showInputView: .constant(true))
}

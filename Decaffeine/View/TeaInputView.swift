//
//  TeaInputView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 3/10/2023.
//

import SwiftUI

struct TeaInputView: View {
    @ObservedObject var viewModel = BeverageViewModel()
    @Binding var showInputView: Bool
    @State private var teaName : String = ""
    
    var body: some View {
        VStack {
            TextField("Enter coffee name", text: $teaName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Save") {
//                viewModel.addTea(name: teaName)
                showInputView = false
            }
            .padding()
        }
        .navigationTitle("Tea Input")
    }
}


#Preview {
    TeaInputView(showInputView: .constant(true))
}

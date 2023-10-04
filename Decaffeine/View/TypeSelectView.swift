//
//  TypeSelectView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 2/10/2023.
//

import SwiftUI

struct TypeSelectView: View {
    @Binding var showInputView: Bool

    var body: some View {
        VStack {
            NavigationLink(destination: CoffeeInputView(showInputView: $showInputView)) {
                Text("Go to Coffee Input")
            }
            
            NavigationLink(destination: TeaInputView(showInputView: $showInputView)) {
                Text("Go to Tea Input")
            }
        }
        .navigationTitle("Type Select")
    }
}

#Preview {
    TypeSelectView(showInputView: .constant(true))
}

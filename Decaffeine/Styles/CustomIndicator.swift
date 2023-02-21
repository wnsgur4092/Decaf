//
//  CustomIndicator.swift
//  Decaffeine
//
//  Created by Jordan Pazdjara on 21/2/2023.
//

import SwiftUI

struct CustomIndicator: View {
    var count: Int
    @Binding var current: Int
    
    var body: some View {
        HStack {
            ForEach(0..<count, id: \.self) { index in
                Circle()
                    .fill(index == current ? Color.black : Color.gray)
                    .frame(width: 10, height: 10)
                    .scaledToFill()
            }
        }
    }
}

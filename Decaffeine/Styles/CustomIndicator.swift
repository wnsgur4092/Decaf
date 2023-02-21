//
//  CustomIndicator.swift
//  Decaffeine
//
//  Created by Jordan Pazdjara on 21/2/2023.
//

import SwiftUI

struct CustomIndicator: View {
    
    @State var homViewModel = HomeViewModel()
    var count : Int
    @Binding var current: Int
    
    var body: some View {
        
        HStack {
            ForEach(0 ..< count, id: \.self) { index in
                VStack {
                    if (current - 1) == index {
                        Circle()
                            .fill(Color.black)
                            .frame(width: 10, height: 10)
                    } else {
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 10, height: 10)
//                                .overlay(
//                                    Circle()
//                                        .stroke(Color.purple, lineWidth: 1.5)
//                                )
                    }
                }
                .scaledToFill()
//                    .frame(width: .infinity, height: 50)
            }
        }
    }
}

//struct CustomIndicator_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomIndicator(count: 3, current: .constant() )
//    }
//}

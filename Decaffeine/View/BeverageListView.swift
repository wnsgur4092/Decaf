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
        VStack{
            HStack{
                Text("#COFFEE")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.black))
                
                Spacer()
            }
            
            HStack{
                Text("Latte")
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            .padding(20)
            .background(Color.onBackgroundTertiary)
            .cornerRadius(8)
        }
        .padding()
    }
}

#Preview {
    TypeSelectView(showInputView: .constant(true))
}

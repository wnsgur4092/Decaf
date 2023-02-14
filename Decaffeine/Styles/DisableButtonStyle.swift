//
//  DisableButtonStyle.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 13/2/2023.
//

import Foundation
import SwiftUI


struct DisableButtonStyle: ButtonStyle {
    //MARK: - PROPERTIES
    let bgColor : Color = Color("gray")
    let textColor : Color = Color.white
    
    //MARK: - FUNCTION
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label.foregroundColor(textColor)
            
            .padding(.vertical, 20)
            .padding(.horizontal, 15)
    }
//        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .background(bgColor.cornerRadius(28))
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

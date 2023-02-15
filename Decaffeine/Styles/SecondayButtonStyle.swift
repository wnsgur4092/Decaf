//
//  SecondayButtonStyle.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 15/2/2023.
//


import Foundation
import SwiftUI

struct SecondaryButtonStyle: ButtonStyle {
    //MARK: - PROPERTIES
    let bgColor : Color = Color.white
    let textColor : Color = Color("mainColor")
    let borderColor : Color = Color("mainColor")
    
    //MARK: - FUNCTION
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label.foregroundColor(textColor)
                .font(.system(size: 16).bold())
            
                .padding(.vertical, 20)
                .padding(.horizontal, 15)
            

            
        }
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 28)
                .stroke(borderColor, lineWidth: 1)
        )
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

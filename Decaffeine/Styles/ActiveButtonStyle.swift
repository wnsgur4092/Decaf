//
//  ActiveButtonStyle.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 13/2/2023.
//

import Foundation
import SwiftUI

struct ActiveButtonStyle: ButtonStyle {
    //MARK: - PROPERTIES
    let bgColor : Color = Color("mainColor")
    let textColor : Color = Color.white
    
    //MARK: - FUNCTION
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label.foregroundColor(textColor)
                
                .padding(20)
        }
        .frame(maxWidth: 140)
        .background(bgColor.cornerRadius(28))
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

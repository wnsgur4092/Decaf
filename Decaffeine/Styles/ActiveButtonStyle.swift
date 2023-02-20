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
                .font(.system(size: 16).bold())
                .padding(.vertical, 20)
                .padding(.horizontal, 15)
        }
        .frame(maxWidth: .infinity)
        .background(bgColor.cornerRadius(28))
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

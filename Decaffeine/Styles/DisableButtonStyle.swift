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
                .font(.system(size: 16).bold())
                .padding(.vertical, 20)
                .padding(.horizontal, 15)
        }
        .disabled(true) // 버튼을 비활성화합니다.
        .frame(maxWidth: .infinity)
        .background(bgColor.cornerRadius(28))
    }
}

//
//  ActiveButton.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 7/8/2024.
//

import SwiftUI

struct ActiveButton: View {
    
    var label: String
    var iconName : String?
    var iconImage : Image?
    var action: () -> Void
    let mainColor : Color = Color("mainColor")
    
    var body: some View {
        Button(action: action, label: {
            HStack(alignment: .center, spacing: 20) {
                if let iconImage = iconImage{
                    iconImage
                        .resizable()
                        .frame(width: 20, height: 20)
                } else if let iconName = iconName {
                    Image(systemName : iconName)
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                Text(label)

            }
        })
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(mainColor.cornerRadius(20))
        .shadow(color:.black.opacity(0.3), radius: 4, x:0, y:2)
    }
}

#Preview {
    ActiveButton(label: "login", action: {})
}

//
//  CustomCorner.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 14/2/2023.
//

import SwiftUI

struct CustomCorner: Shape {
    

    var corners : UIRectCorner
    var radius : CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            
        return Path(path.cgPath)
    }

}

struct CustomCorner_Previews: PreviewProvider {
    static var previews: some View {
        CustomCorner(corners: [.topLeft,.topRight], radius: 25)
    }
}

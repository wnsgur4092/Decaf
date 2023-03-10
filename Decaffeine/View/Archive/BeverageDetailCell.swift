//
//  BeverageDetailCell.swift
//  Decaffeine
//
//  Created by Jordan Pazdjara on 15/2/2023.
//

import Foundation
import SwiftUI

struct BeverageDetailCell: View {
    //MARK: - PROPERTIES
    var detailImageName : String
    var detailName : String
    var detailExtra : String
    
    //MARK: - BODY
    var body: some View {
        VStack(alignment: .center, spacing: 10){
            Text(detailName)
                .font(.system(size: 16))
                .fontWeight(.bold)
            
            Image(detailImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 60)
            
            Text(detailExtra)
                .font(.system(size: 14))
                .fontWeight(.regular)
        }
    }
}

struct BeverageDetailCell_Previews: PreviewProvider {
    static var previews: some View {
        BeverageDetailCell(detailImageName: "longblack", detailName: "LongBlack", detailExtra: "Large").previewLayout(.sizeThatFits)
    }
}

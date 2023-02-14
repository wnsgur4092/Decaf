//
//  BeverageCell.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 15/2/2023.
//

import SwiftUI

struct BeverageCell: View {
    //MARK: - PROPERTIES
    var beverageImageName : String
    var beverageName : String
    
    //MARK: - BODY
    var body: some View {
        VStack(alignment: .center, spacing: 10){
            Image(beverageImageName)
            Text(beverageName)
                .font(.system(size: 14))
        }
        .padding(40)
    }
}

struct BeverageCell_Previews: PreviewProvider {
    static var previews: some View {
        BeverageCell(beverageImageName: "longblack", beverageName: "LongBlack").previewLayout(.sizeThatFits)
    }
}

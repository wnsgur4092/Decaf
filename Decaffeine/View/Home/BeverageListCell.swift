//
//  BeverageListCell.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 20/2/2023.
//

import SwiftUI

struct BeverageListCell: View {
    let beverageName : String
    let beverageImageName : String
    
    var body: some View {
        VStack(alignment: .center){
            ZStack{
                Image(beverageImageName)
                    .resizable()
                    .scaledToFit()
                
            }
            .frame(width: 100 , height: 100)
            
            Text(beverageName)
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 20)
        .background(
            ZStack {
                Color.white
                    .cornerRadius(25)
                    .shadow(color: .black.opacity(0.2), radius: 1, x: 2, y: 2)            }
        )
        .padding(.vertical, 20)
    }
}

struct BeverageListCell_Previews: PreviewProvider {
    static var previews: some View {
        BeverageListCell(beverageName: "Latte", beverageImageName: "latte")
    }
}

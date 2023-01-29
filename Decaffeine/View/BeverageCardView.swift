//
//  BeverageCardView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 29/1/2023.
//

import SwiftUI

struct BeverageCardView: View {
    var beverage: Beverage

    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            Image(beverage.coffeeImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding(4)
            
            Text(beverage.coffeeName)
                .font(.system(size:16, weight: .bold))
            
        }
        .frame(width: 120, height: 160)
//        .background(Color.primary.colorInvert())
//        .cornerRadius(10)
//
//        .shadow(color: Color.primary.opacity(0.3), radius: 1, x: 5, y: 5)
    }
}

struct BeverageCardView_Previews: PreviewProvider {
    static var previews: some View {
        BeverageCardView(beverage: Beverage.beverageList[0])
            .previewLayout(.fixed(width: 160, height: 250))
    }
}

//
//  TypeSelectView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 11/7/2023.
//

import SwiftUI

struct TypeSelectView: View {
    var body: some View {
        VStack(spacing: 24) {
            
            VStack(spacing: -10){ // decrease this value
                Image("HotCoffee")
                    .resizable()
                    .scaledToFit()
     
                Text("Coffee")
                    .padding(.bottom, 20)
            }
            .overlay(RoundedRectangle(cornerRadius: 12)
                .stroke(Color.black, lineWidth: 4))
            
            VStack(spacing: -10){ // decrease this value
                Image("HotTea")
                    .resizable()
                    .scaledToFit()
     
                Text("Tea")
                    .padding(.bottom, 20)
            }
            .overlay(RoundedRectangle(cornerRadius: 12)
                .stroke(Color.black, lineWidth: 4))
            
            VStack(spacing: -10){ // decrease this value
                Image("Drink")
                    .resizable()
                    .scaledToFit()
     
                Text("Drink")
                    .padding(.bottom, 20)
            }
            .overlay(RoundedRectangle(cornerRadius: 12)
                .stroke(Color.black, lineWidth: 4))
            
        }
        .padding(.vertical, 50)
        .navigationBarBackButtonHidden(true)
    }
}


struct TypeSelectView_Previews: PreviewProvider {
    static var previews: some View {
        TypeSelectView()
    }
}

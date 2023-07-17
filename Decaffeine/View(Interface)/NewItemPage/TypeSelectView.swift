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
            
            TypeSelectCard(typeImageName: "HotCoffee", typeName: "Coffee")
            
            TypeSelectCard(typeImageName: "HotTea", typeName: "Tea")
            
            TypeSelectCard(typeImageName: "Drink", typeName: "Drink")
            
        }
        .padding(.vertical, 50)
        .navigationBarBackButtonHidden(true)
    }
}

//MARK: - COMPONENTS
struct TypeSelectCard : View {
    var typeImageName : String
    var typeName : String
    
    var body : some View {
        NavigationLink {
            NewAddView(coffeeName: "")
        } label: {
            VStack(spacing: -10){ // decrease this value
                Image(typeImageName)
                    .resizable()
                    .scaledToFit()
                
                Text(typeName)
                    .padding(.bottom, 20)
            }
            .overlay(RoundedRectangle(cornerRadius: 12)
                .stroke(Color.black, lineWidth: 4))
        }
    }
}


//MARK: - PREVIEW
struct TypeSelectView_Previews: PreviewProvider {
    static var previews: some View {
        TypeSelectView()
    }
}

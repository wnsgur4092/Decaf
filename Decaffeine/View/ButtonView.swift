//
//  ButtonView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 30/1/2023.
//

import SwiftUI

struct ButtonView: View {
    //MARK: - PROPERTIES
    
    var text : String = "Full cream milk"
    
    var body: some View {
        VStack{
            Text(text)
                .foregroundColor(.purple)
                .fontWeight(.semibold)
                .padding(.top)
        }
        //: VSTACK
           .padding(.horizontal, 20)
           .padding(.bottom, 22)
           .background(
               Color.white
                   .cornerRadius(25)
                   .shadow(color: .black.opacity(0.2), radius: 1, x: 2, y: 2)
           )
    }
}


struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}

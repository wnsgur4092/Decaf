//
//  NewAddView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 7/7/2023.
//

import SwiftUI

struct NewAddView: View {
    //MARK: - PROPERTEIS
    
    //MARK: - BODY
    var body: some View {
        ScrollView{
            Image("HotCup")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 150)
            
        }
        .background(Color("BackgroundColor"))
    }
    
}


struct NewAddView_Previews: PreviewProvider {
    static var previews: some View {
        NewAddView()
    }
}

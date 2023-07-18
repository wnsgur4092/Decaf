//
//  FavoriteNameListView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 18/7/2023.
//

import SwiftUI

struct FavoriteNameListView: View {
    var body: some View {
        VStack{
            HStack{
                Text("Coffee")
                
                Text("Tea")
                
                Text("Drink")
            }
        }
    }
}

struct FavoriteNameListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteNameListView()
    }
}

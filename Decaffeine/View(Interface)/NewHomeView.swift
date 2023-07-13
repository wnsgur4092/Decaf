//
//  NewHomeView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 7/7/2023.
//

import SwiftUI

struct NewHomeView: View {
    var body: some View {
        NavigationView {
            VStack{
                Text("Click Below")
                
                NavigationLink {
                    TypeSelectView()
                } label: {
                    Text("Click")
                }
                
                
            }
        }
    }
}

struct NewHomeView_Previews: PreviewProvider {
    static var previews: some View {
        NewHomeView()
    }
}

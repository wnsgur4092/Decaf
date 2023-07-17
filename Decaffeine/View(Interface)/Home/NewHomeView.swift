//
//  NewHomeView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 7/7/2023.
//

import SwiftUI

struct NewHomeView: View {
    //MARK: - PROPERTIES
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            VStack(spacing : 0) {
                NavigationBarView()
                
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing:0) {
                        
                        Image("HotTea")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                        
                        VStack{
                            HStack{
                                Text("FAVORITE")
                                
                                Spacer()
                                
                                Text("MORE")
                            }
          
                        }
     
                    } //: VSTACK
                } //: SCROLL
            } //: VSTACK
            .background(colorBackground.ignoresSafeArea(.all, edges:.all))
            
        }
    } //: ZSTACK
    
}


struct NewHomeView_Previews: PreviewProvider {
    static var previews: some View {
        NewHomeView()
    }
}

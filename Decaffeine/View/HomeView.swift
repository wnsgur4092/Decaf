//
//  HomeView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 29/1/2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            HStack{
                Text("Today, 10 Jun")
                
                Spacer()
                
                Image("defaultProfileImage")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 40, maxHeight: 40)
            }
            
            VStack{
                Image("noList")
                
                Text("No Caffeine Record Yet")
                Text("Create the Caffeine History")
            }
            
            VStack{
                Text("You drunk total 0 Coffees")
                
                HStack{
                    Text("Today's Total Caffeine")
                    Text("0/400mg")
                }
                
                //Bar Graph
                ZStack(alignment: .leading){
                    Text("0%")
                        .padding(.horizontal,20)
                        .foregroundColor(.white)
                        .zIndex(1)
                    
                    RoundedRectangle(cornerRadius: 11)
                        .frame(maxHeight: 34)
                        .foregroundColor(.gray)

                }
            }
            
            Button {
                print("Add New Caffeine Button Tapped")
            } label: {
                ZStack{
                    Text("+ Add New Caffeine")
                        .foregroundColor(.white)
                        .zIndex(1)

                    RoundedRectangle(cornerRadius: 11)
                        .frame(maxWidth: .infinity, maxHeight: 56)
                }
                 
            } //: BUTTON
        }
        .padding(.horizontal, 20)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

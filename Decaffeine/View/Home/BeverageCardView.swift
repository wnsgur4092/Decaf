//
//  BeverageCardView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 20/2/2023.
//

import SwiftUI

struct BeverageCardView: View {
    //MARK: - PROPERTIES
    let beverageName : String
    let beverageImageName : String
    @State private var isAnimaiting : Bool = false
    
    //MARK: - BODY
    var body: some View {
        
        ZStack{
            VStack(alignment: .center, spacing: 32){
                
                Image(beverageImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160 , height: 198)
                    .scaleEffect(isAnimaiting ? 1.0 : 0.6)
      
                Text(beverageName)
                    .lineLimit(2)
                    .font(.system(size: 24).bold())
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    
            }
            .padding(20)
        }
        .onAppear{
            withAnimation(.easeOut(duration: 0.5)){
                isAnimaiting = true
            }
        }
        .frame(maxWidth:.infinity, maxHeight: 400)
        .background(Color("mainColor"))

        .cornerRadius(20)
        
        .padding(.horizontal , 32)
        .shadow(color: .black.opacity(0.3), radius: 1, x: 1, y: 1)
    }
}

struct BeverageCardView_Previews: PreviewProvider {
    static var previews: some View {
        BeverageCardView(beverageName: "Iced Long Black ", beverageImageName: "icedlongblack")
    }
}

//
//  BeverageCell.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 15/2/2023.
//

import SwiftUI

struct BeverageCell: View {
    //MARK: - PROPERTIES
    var beverageImageName : String
    var beverageName : String
    var index: Int
    @Binding var selectedBeverageIndex : Int?
    
    //MARK: - BODY
    var body: some View {
        ZStack{
            VStack(alignment: .center, spacing: 20){
                Image(beverageImageName)
                    .resizable()
                    .scaledToFit()
                    .shadow(color: Color.black.opacity(0.15), radius: 8, x: 6, y: 8)
                
                
                Text(beverageName)
                    .font(.system(size: 14))
                    .foregroundColor(.black)
            }
            .frame(width: 120 , height: 140)
            .padding(20)
            .border(.black, width: 1 )

            .background(
                selectedBeverageIndex == index ? Color.blue.opacity(0.2) : Color.white
            )
            .foregroundColor(Color.primary)
        }
    }
}

//MARK: - PREVIEW
struct BeverageCell_Previews: PreviewProvider {
    static var previews: some View {
        BeverageCell(beverageImageName: "icedlongblack", beverageName: "Iced  Long Black", index: 0, selectedBeverageIndex: .constant(nil))
    }
}


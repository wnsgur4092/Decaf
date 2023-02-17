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
        VStack(alignment: .center){
            ZStack{
                Image(beverageImageName)
                    .resizable()
                    .scaledToFit()
                
            }
            .frame(width: 100 , height: 100)
            
            Text(beverageName)
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 20)
        .background(
            ZStack {
                Color.white
                    .cornerRadius(25)
                    .shadow(color: .black.opacity(0.2), radius: 1, x: 2, y: 2)
                if selectedBeverageIndex == index {
                    Color.blue.opacity(0.2)
                        .cornerRadius(25)
                }
            }
        )
        .padding(.vertical, 20)
    }
}

//MARK: - PREVIEW
struct BeverageCell_Previews: PreviewProvider {
    static var previews: some View {
        BeverageCell(beverageImageName: "latte", beverageName: "Iced  Long Black", index: 0, selectedBeverageIndex: .constant(nil))
    }
}


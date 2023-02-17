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
    
    //MARK: - BODY
    var body: some View {
        VStack{
            ZStack{
                Image(beverageImageName)
                    .resizable()
                    .scaledToFit()
                    
            }
            .frame(width: getRect().width / 2.5 , height: getRect().width / 2.5)
        }
//        VStack(alignment: .center, spacing: 10){
//            Image(beverageImageName)
//            Text(beverageName)
//                .font(.system(size: 14))
//        }
//        .padding(40)
//
//        .overlay(RoundedRectangle(cornerRadius: 11).stroke(lineWidth: 1).shadow(color: .black, radius: 1, x: 0, y: 1))
        
    }
}

extension View{
    func getRect() -> CGRect{
        return UIScreen.main.bounds
    }
}

struct BeverageCell_Previews: PreviewProvider {
    static var previews: some View {
        BeverageCell(beverageImageName: "longblack", beverageName: "LongBlack").previewLayout(.sizeThatFits)
    }
}

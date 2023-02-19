//
//  Beverage.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 19/2/2023.
//

import Foundation



struct Beverage : Identifiable, Codable, Hashable {
    var id : Int
    var category : BeverageCategory
    var beverageName : String
    var beverageImageName : String
    
}

enum BeverageCategory : String, Codable ,CaseIterable{
    case hot = "Hot"
    case cold = "Cold"
}

extension Beverage {
    static let beverageList : [Beverage] = [
        Beverage(id: 1, category: .hot, beverageName: "Cappuccino", beverageImageName: "cappuccino"),
        Beverage(id: 2, category: .hot, beverageName: "Long Black", beverageImageName: "longblack"),
        Beverage(id: 3, category: .hot, beverageName: "Latte", beverageImageName: "latte"),
        Beverage(id: 4, category: .cold, beverageName: "Iced Long Black", beverageImageName: "")
    ]
}

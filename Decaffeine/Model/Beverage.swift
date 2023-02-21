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
        Beverage(id: 2, category: .hot, beverageName: "Espresso", beverageImageName: "espresso"),
        Beverage(id: 3, category: .hot, beverageName: "Flat White", beverageImageName: "flatwhite"),
        Beverage(id: 4, category: .cold, beverageName: "Iced Banana Coffee", beverageImageName: "icedbananacoffee"),
        Beverage(id: 5, category: .cold, beverageName: "Iced Caramel Latte", beverageImageName: "icedcaramellatte"),
        Beverage(id: 6, category: .cold, beverageName: "Iced Coffee", beverageImageName: "icedcoffee"),
        Beverage(id: 7, category: .cold, beverageName: "Iced Latte", beverageImageName: "icedlatte"),
        Beverage(id: 8, category: .cold, beverageName: "Iced Long Black", beverageImageName: "icedlongblack"),
        Beverage(id: 9, category: .cold, beverageName: "Iced Mocha", beverageImageName: "icedmocha"),
        Beverage(id: 10, category: .cold, beverageName: "Iced Vanilla Latte", beverageImageName: "icedvanillalatte"),
        Beverage(id: 11, category: .hot, beverageName: "Latte", beverageImageName: "latte"),
        Beverage(id: 12, category: .hot, beverageName: "Long Black", beverageImageName: "longblack"),
        Beverage(id: 13, category: .hot, beverageName: "Mocha", beverageImageName: "mocha")
    ]
}

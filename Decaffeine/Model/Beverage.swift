//
//  Beverage.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 19/2/2023.
//

import Foundation

enum BeverageCategory: String, CaseIterable {
    case hot = "Hot"
    case cold = "Cold"
}

struct Beverage: Identifiable {
    let id: Int
    let category: BeverageCategory
    let beverageName: String
    let beverageImageName: String
    let color : String
}

extension Beverage {
    static let beverageList : [Beverage] = [
        Beverage(id: 1, category: .hot, beverageName: "Cappuccino", beverageImageName: "cappuccino", color: "Black"),
        Beverage(id: 2, category: .hot, beverageName: "Espresso", beverageImageName: "espresso", color: "Gray"),
        Beverage(id: 3, category: .hot, beverageName: "Flat White", beverageImageName: "flatwhite", color: "White"),
        Beverage(id: 4, category: .cold, beverageName: "Iced Banana Coffee", beverageImageName: "icedbananacoffee", color: "Yellow"),
        Beverage(id: 5, category: .cold, beverageName: "Iced Caramel Latte", beverageImageName: "icedcaramellatte", color: "Orange"),
        Beverage(id: 6, category: .cold, beverageName: "Iced Coffee", beverageImageName: "icedcoffee", color: "Brown"),
        Beverage(id: 7, category: .cold, beverageName: "Iced Latte", beverageImageName: "icedlatte", color: "Purple"),
        Beverage(id: 8, category: .cold, beverageName: "Iced Long Black", beverageImageName: "icedlongblack", color: "Blue"),
        Beverage(id: 9, category: .cold, beverageName: "Iced Mocha", beverageImageName: "icedmocha", color: "Green"),
        Beverage(id: 10, category: .cold, beverageName: "Iced Vanilla Latte", beverageImageName: "icedvanillalatte", color: "Pink"),
        Beverage(id: 11, category: .hot, beverageName: "Latte", beverageImageName: "latte", color: "Red"),
        Beverage(id: 12, category: .hot, beverageName: "Long Black", beverageImageName: "longblack", color: "Blue"),
        Beverage(id: 13, category: .hot, beverageName: "Mocha", beverageImageName: "mocha", color: "Green")
    ]
}

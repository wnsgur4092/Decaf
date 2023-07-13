//
//  CaffeineBeverage.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 13/7/2023.
//

import Foundation

// Enum for Beverage Types
enum BeverageType {
    case coffee(CoffeeType)
    case tea(TeaType)
    case drink(Drink)
}

// Struct for Coffee Type
enum CoffeeType {
    case cold(coffeeName: String, coffeeImage: String)
    case hot(coffeeName: String, coffeeImage: String)
}

// Struct for Tea Type
enum TeaType {
    case cold(teaName: String, teaImage: String)
    case hot(teaName: String, teaImage: String)
}

// Struct for Drink
struct Drink {
    let drinkName: String
    let drinkImage: String
}

// Struct for Caffeinated Beverage
struct CaffeineBeverage {
    let beverageType: BeverageType
}

extension CaffeineBeverage {
    static let caffeinatedBeverage : [CaffeineBeverage] = [
        CaffeineBeverage(beverageType: .coffee(.cold(coffeeName: "Iced Long Black", coffeeImage: "IceCoffee"))),
        CaffeineBeverage(beverageType: .coffee(.cold(coffeeName: "Iced Latte", coffeeImage: "IceCoffee"))),
        CaffeineBeverage(beverageType: .coffee(.hot(coffeeName: "Cappuccino", coffeeImage: "HotCoffee"))),
        CaffeineBeverage(beverageType: .coffee(.hot(coffeeName: "Latte", coffeeImage: "HotCoffee"))),
        CaffeineBeverage(beverageType: .drink(Drink(drinkName: "Redbull", drinkImage: "Drink")))
    ]
}

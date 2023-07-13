//
//  CaffeineBeverage.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 13/7/2023.
//

import Foundation

struct CaffeineBeverage {
    let coffee: Coffee
    let tea: Tea
    let drink: Drink
}

struct Coffee {
    let hotCoffee: CoffeeType
    let coldCoffee: CoffeeType
}

struct CoffeeType {
    let coffeeName: String
    let coffeeImage: String 
}

struct Tea {
    let hotTea: TeaType
    let coldTea: TeaType
}

struct TeaType {
    let teaName: String
    let teaImage: String 
}

struct Drink {
    let drinkName: String
    let drinkImage : String
}

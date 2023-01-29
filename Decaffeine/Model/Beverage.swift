//
//  Beverage.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 29/1/2023.
//

import SwiftUI

struct Beverage : Hashable, Identifiable {
    var id: UUID = UUID()
    var coffeeName : String
    var coffeeImageName : String
    var beverageType : BeverageType

}

enum BeverageType {
    case hotCoffee
    case coldCoffee
}


extension Beverage {
    static let beverageList : [Beverage] = [
        Beverage(coffeeName: "Cappucino", coffeeImageName: "Cappucino", beverageType: .hotCoffee),
        Beverage(coffeeName: "Latte", coffeeImageName: "Latte", beverageType: .hotCoffee),
        Beverage(coffeeName: "Flatwhite", coffeeImageName: "Flatwhite", beverageType: .hotCoffee),
        Beverage(coffeeName: "Ice Long Black", coffeeImageName: "IceLongBlack", beverageType:.coldCoffee),
        Beverage(coffeeName: "Ice Latte", coffeeImageName: "IceLatte", beverageType: .coldCoffee)
    ]
}











//
//  Beverage.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 29/1/2023.
//

import SwiftUI

struct Beverage : Identifiable {
    var id: UUID = UUID()
    var beverageType : BeverageType
    var coffeeType : coffeeType
}

enum BeverageType {
    case hotCoffee
    case coldCoffee
}

enum coffeeType : String, Codable, CaseIterable {
    case cappuccino
    case latte
    case iceLongBlack
    case iceLatte

    
    var imageName : String {
        switch self {
        case .cappuccino : return  "Cappuccino"
        case .latte : return  "Latte"
        case .iceLongBlack : return  "IceLongBlack"
        case .iceLatte : return  "IceLatte"
        }
    }
    
    var name : String {
        switch self {
        case .cappuccino : return  "Cappuccino"
        case .latte : return  "Latte"
        case .iceLongBlack : return  "IceLongBlack"
        case .iceLatte : return  "IceLatte"

        }
    }

}

extension Beverage {
    static let beverageList : [Beverage] = [
        Beverage(beverageType: .hotCoffee, coffeeType: .cappuccino),
        Beverage(beverageType: .hotCoffee, coffeeType: .latte),
        Beverage(beverageType: .coldCoffee, coffeeType: .iceLongBlack),
        Beverage(beverageType: .coldCoffee, coffeeType: .iceLatte)
    ]
}











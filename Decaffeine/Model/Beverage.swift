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
    var type : BeverageType

}

enum BeverageType : String, CaseIterable {
    case HotCoffee
    case ColdCoffee
}













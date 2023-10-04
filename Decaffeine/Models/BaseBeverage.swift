//
//  BaseBeverage.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 4/10/2023.
//

import Foundation

enum CoffeeTag: String, CaseIterable {
    case espresso = "Espresso"
    case longBlack = "Long Black"
    case latte = "Latte"
    case cappuccino = "Cappuccino"
    case caffeMocha = "Caffe Mocha"
}

enum TeaTag: String, CaseIterable {
    case greenTea = "Green tea"
    case blackTea = "Black tea"
    case camomileTea = "Camomile tea"
}

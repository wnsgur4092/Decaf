//
//  CoffeeModel.swift
//  Decaffeine
//
//  Created by Jordan Pazdjara on 20/2/2023.
//

import SwiftUI

struct Coffee : Identifiable {
    var id: Int
    var title: String
    var imageName : String
}

var coffeeTypes = [Coffee(id: 0, title: "Iced Coffee", imageName: "cicedcoffee"),
                   Coffee(id: 1, title: "Iced Mocha", imageName: "cicedmocha"),
                   Coffee(id: 2, title: "Iced Latte", imageName: "cicedlatte"),
                   Coffee(id: 3, title: "Iced Caramel Latte", imageName: "cicedcaramellatte"),
                   Coffee(id: 4, title: "Iced Banana Milk Coffee", imageName: "cbananamilkicedcoffee"),
                   Coffee(id: 5, title: "Iced Long Black", imageName: "cicedlongblack")
]

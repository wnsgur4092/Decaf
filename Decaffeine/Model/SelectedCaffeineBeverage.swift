//
//  SelectedCaffeineBeverage.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 13/7/2023.
//

import Foundation
import SwiftUI
import RealmSwift

class SelectedCaffeineBeverage: Object {
    @Persisted var beverageName: String = ""
    @Persisted var beverageImage: String = ""
    @Persisted var type: String = ""
    @Persisted var size: String = ""
    @Persisted var date: Date = Date()
    @Persisted var caffeine: Int = 0
    
    convenience init(beverage: CaffeineBeverage, size: String, caffeine: Int) {
        self.init()
        
        switch beverage.beverageType {
        case .coffee(let coffeeType):
            switch coffeeType {
            case .cold(let coffeeName, let coffeeImage):
                self.beverageName = coffeeName
                self.beverageImage = coffeeImage
                self.type = "Cold Coffee"
            case .hot(let coffeeName, let coffeeImage):
                self.beverageName = coffeeName
                self.beverageImage = coffeeImage
                self.type = "Hot Coffee"
            }
        case .tea(let teaType):
            switch teaType {
            case .cold(let teaName, let teaImage):
                self.beverageName = teaName
                self.beverageImage = teaImage
                self.type = "Cold Tea"
            case .hot(let teaName, let teaImage):
                self.beverageName = teaName
                self.beverageImage = teaImage
                self.type = "Hot Tea"
            }
        case .drink(let drink):
            self.beverageName = drink.drinkName
            self.beverageImage = drink.drinkImage
            self.type = "Drink"
        }
        
        self.size = size
        self.caffeine = caffeine
    }
}

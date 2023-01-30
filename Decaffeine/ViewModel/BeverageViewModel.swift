//
//  BeverageViewModel.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 29/1/2023.
//
//
import Foundation
import SwiftUI
import Combine

class BeverageViewModel: ObservableObject {
    @Published var beverages: [Beverage] = [
        Beverage(coffeeName: "Cappucino", coffeeImageName: "Cappucino", type: .HotCoffee),
        Beverage(coffeeName: "Latte", coffeeImageName: "Latte", type: .HotCoffee),
        Beverage(coffeeName: "Flatwhite", coffeeImageName: "Flatwhite", type: .HotCoffee),
        Beverage(coffeeName: "Ice Long Black", coffeeImageName: "IceLongBlack", type: .ColdCoffee),
        Beverage(coffeeName: "Ice Latte", coffeeImageName: "IceLatte", type: .ColdCoffee)
    ]
    
    @Published var filteredBeverages: [Beverage] = []
    

    
    @Published var beverageType: BeverageType = .HotCoffee
    @Published var numberOfShots = ["half", "one", "two", "three", "four"]
    @Published var milkType = ["Full Cream", "Skim", "Soy", "Almond"]
    @Published var coffeeSize = ["Small", "Regular", "Large"]
    
    init() {

    }
    
    func filterProductByType(_ type: BeverageType) {
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.beverages
                .lazy
                .filter { beverage in
                    return beverage.type == type
                }
                .prefix(4)
            
            DispatchQueue.main.async {
                self.filteredBeverages = results.compactMap({ beverage in
                    return beverage
                })
            }
        }
    }
}


//
//  BeverageAddViewModel.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 17/2/2023.
//

import Foundation
import SwiftUI
import Combine
import RealmSwift

class BeverageAddViewModel : ObservableObject {
    
    
    @Published var coffees : Binding<[CoffeeModel]>
    @Published var coffee : CoffeeModel = CoffeeModel()
    
    @Published var coffeeName : String = "" //Coffee Name
    @Published var coffeeImageName : String = "" //Color Description
    
    @Published var numberOfShots : Double = 1.0 //Color R
    @Published var size : String = "Regular"
    @Published var registerDate : Date = Date()
    
    var subscriptions = Set<AnyCancellable>()
    
    init(coffees : Binding<[CoffeeModel]>) {
        self.coffees = coffees
        
        
        $coffeeName.sink { coffeeName in
            self.update(coffeeName: coffeeName)
        }.store(in: &subscriptions)
        
        $coffeeImageName.sink { coffeeImageName in
            self.update(coffeeImageName: coffeeImageName)
        }.store(in: &subscriptions)
        
        $numberOfShots.sink { numberOfShots in
            self.update(numberOfShots: numberOfShots)
        }.store(in: &subscriptions)
        
        $size.sink { size in
            self.update(size: size)
        }.store(in: &subscriptions)
        
        
    }
    
    //MARK: - FUNCTION
    private func update(coffeeName : String) {
        self.coffee.coffeeName = coffeeName
    }
    
    private func update(numberOfShots : Double) {
        self.coffee.numberOfShots = numberOfShots
    }
    
    private func update(size: String){
        self.coffee.size = size
    }
    
    private func update(coffeeImageName : String) {
        self.coffee.coffeeImageName = coffeeImageName
    }
    
    private func update(registerDate : Date) {
        self.coffee.registerDate = registerDate
    }
    
}

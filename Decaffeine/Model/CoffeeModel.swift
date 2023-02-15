//
//  CoffeeModel.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 15/2/2023.
//

import Foundation

class CoffeeModel : Identifiable {
    
    //Vandan Add
    var id : UUID = UUID()
    var coffeeName : String = ""
    var coffeeImageName : String = ""
    var numberOfShots : Double = 0.0
    var size : String = ""
}

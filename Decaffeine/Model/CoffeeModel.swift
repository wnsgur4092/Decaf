//
//  CoffeeModel.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 15/2/2023.
//

import Foundation
import RealmSwift

class CoffeeModel : Object, Identifiable, Codable {
    
    //Vandan Add
    @Persisted var id : UUID = UUID()
    @Persisted var coffeeName : String = ""
    @Persisted var coffeeImageName : String = ""
    @Persisted var numberOfShots : Double = 0.0
    @Persisted var size : String = ""
    @Persisted var registerDate : Date = Date()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

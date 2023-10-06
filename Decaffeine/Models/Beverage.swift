//
//  Beverage.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 2/10/2023.
//


import Foundation
import RealmSwift

class Beverage: Object {
    
    @Persisted var id : UUID = UUID()
    @Persisted var beverageName : String
    @Persisted var bevereageType : String
    @Persisted var registerDate : Date = Date()
    @Persisted var beverageImageName : String
    @Persisted var beverageCaffeine : Double
    @Persisted var beverageShot : Double?
    @Persisted var beverageSize : Int?
}

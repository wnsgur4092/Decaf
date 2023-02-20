//
//  SelectedBeverage.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 19/2/2023.
//

import Foundation
import RealmSwift

class SelectedBeverage : Object, Identifiable, Codable {
    
    //Vandan Add
    @Persisted var id : UUID = UUID()
    @Persisted var name : String = ""
    @Persisted var imageName : String = ""
    @Persisted var numberOfShots : Double = 1.0
    @Persisted var size : String = ""
    @Persisted var registerDate : Date = Date()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}


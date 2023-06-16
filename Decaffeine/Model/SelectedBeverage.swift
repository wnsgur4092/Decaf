//
//  SelectedBeverage.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 19/2/2023.
//

import Foundation
import RealmSwift

class SelectedBeverage : Object, Identifiable, Codable {
    
    @Persisted var id : UUID = UUID()
    @Persisted var name : String = ""
    @Persisted var imageName : String = ""
    @Persisted var numberOfShots : Double = 0.5
    @Persisted var size : String = ""
    @Persisted var registerDate : Date = Date()
    @Persisted var caffeine : Double = 0.0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
//    private var dateComponent: DateComponents {
//        let calendar = Calendar(identifier: .gregorian)
//        let dc = calendar.dateComponents([.year, .month], from: self.registerDate)
//        return dc
//    }
}


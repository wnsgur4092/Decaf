//
//  SelectedBeverage.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 19/2/2023.
//

import Foundation

class SelectedBeverage :  Identifiable, Codable {
    
    //Vandan Add
    var id : UUID = UUID()
    var name : String = ""
    var imageName : String = ""
    var numberOfShots : Double = 1.0
    var size : String = ""
    var registerDate : Date = Date()
    
    var caffeine : Int = 0
    
    
}

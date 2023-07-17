//
//  CoffeeTag.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 17/7/2023.
//

import Foundation

struct CoffeeTag : Identifiable, Hashable {
    var id = UUID().uuidString
    var text : String
    var size : CGFloat = 0
}

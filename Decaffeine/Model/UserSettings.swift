//
//  UserSettings.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 29/1/2023.
//

import Foundation

struct UserSettings {
    var gender: Gender
    var coffeePrice: Double
}

enum Gender: String, CaseIterable {
    case male, female
}

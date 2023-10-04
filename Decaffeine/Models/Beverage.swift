//
//  Beverage.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 2/10/2023.
//


import Foundation
import RealmSwift

protocol Beverage {
    var generalName: String { get }
}


class Coffee: Object, Beverage {
    @Persisted var id: UUID = UUID()
    @Persisted var hot: Bool = true
    @Persisted var cold: Bool = false
    @Persisted var name: String = ""

    var generalName: String { return name }

    override static func primaryKey() -> String? {
        return "id"
    }
}

class Tea: Object, Beverage {
    @Persisted var id: UUID = UUID()
    @Persisted var name: String = ""

    var generalName: String { return name }

    override static func primaryKey() -> String? {
        return "id"
    }
}

class Drink: Object, Beverage {
    @Persisted var id: UUID = UUID()
    @Persisted var name: String = ""

    var generalName: String { return name }

    override static func primaryKey() -> String? {
        return "id"
    }
}


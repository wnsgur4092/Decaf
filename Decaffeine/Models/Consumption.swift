//
//  Consumption.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 5/10/2023.
//

import Foundation
import RealmSwift

class Consumption: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var date: Date = Date()
    @objc dynamic var beverageName: String = ""
    @objc dynamic var beverageTag: String = ""
    @objc dynamic var shot: Int = 0
    @objc dynamic var caffeine: Int = 0

    override static func primaryKey() -> String? {
        return "id"
    }
}

//
//  DateValue.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 20/6/2023.
//

import SwiftUI

// Date Value Model...
struct DateValue: Identifiable{
    var id = UUID().uuidString
    var day: Int
    var date: Date
}

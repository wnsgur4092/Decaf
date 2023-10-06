//
//  String+++.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 5/10/2023.
//

import Foundation

extension String {
    var capitalizedFirstLetter: String {
        guard !isEmpty else { return self }
        return prefix(1).capitalized + dropFirst()
    }
}

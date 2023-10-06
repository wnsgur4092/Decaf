//
//  BeverageListViewModel.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 4/10/2023.
//

import Foundation

class BeverageListViewModel: ObservableObject {
    enum Filter: String {
        case coffee = "#COFFEE"
        case tea = "#TEA"
        case all = "ALL"
    }

    @Published var activeFilter: Filter = .all

    var coffeeTags: [CoffeeTag] {
        CoffeeTag.allCases
    }

    var teaTags: [TeaTag] {
        TeaTag.allCases
    }
}

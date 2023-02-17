//
//  BeverageListViewModel.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 17/2/2023.
//

import Foundation

class BeverageListViewModel : ObservableObject {
    @Published var coffees : [CoffeeModel] = []
}

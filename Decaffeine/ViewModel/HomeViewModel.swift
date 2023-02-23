//
//  BeverageListViewModel.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 17/2/2023.
//

import Foundation
import Combine
import SwiftUI


class HomeViewModel: ObservableObject {
    @Published var list: [SelectedBeverage] = []
    @Published var dic : [String: [SelectedBeverage]] = [:]
    
    
    let storage : SelectedBeverageStroage
    
    var subscriptions = Set<AnyCancellable>()

    init(storage : SelectedBeverageStroage) {
        self.storage = storage
    }
    
    func persist(items : [SelectedBeverage]) {
        guard items.isEmpty == false else { return }
        self.storage.persist(items)
    }
    
    func fetch() {
        self.list = storage.fetch()
    }

    
    func totalCaffeineForToday() -> Int {
        let calendar = Calendar.current
        let today = Date()
        let filteredList = list.filter {
            calendar.isDate($0.registerDate, inSameDayAs: today)
        }
        let totalCaffeine = filteredList.reduce(0) { $0 + $1.caffeine }
        return totalCaffeine
    }
    
    func numberOfBeveragesForToday() -> Int {
        let calendar = Calendar.current
        let today = Date()
        let filteredList = list.filter {
            calendar.isDate($0.registerDate, inSameDayAs: today)
        }
        return filteredList.count
    }
    
    
}

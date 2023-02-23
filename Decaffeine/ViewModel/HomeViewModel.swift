//
//  BeverageListViewModel.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 17/2/2023.
//

import Foundation
import Combine
import SwiftUI
import RealmSwift


class HomeViewModel: ObservableObject {
    @Published var selectedBeverages : [SelectedBeverage] = []
    @Published var currentDay : Date = Date()
    
    var subscriptions = Set<AnyCancellable>()


    
    init() {
        getSelectedBeverage(for: currentDay)
        print("---> Realm Data File Location :\(Realm.Configuration.defaultConfiguration.fileURL!)")
        
    }
    
    
    func getSelectedBeverage(for day: Date) {
        guard let realm = try? Realm() else { return }
        
        let selectedBeverage = realm.objects(SelectedBeverage.self)
        
        try! realm.write{
            self.selectedBeverages = selectedBeverages.compactMap({$0})
        }
    }

    
    func totalCaffeineForToday() -> Double {
        let calendar = Calendar.current
        let today = Date()
        let filteredList = selectedBeverages.filter {
            calendar.isDate($0.registerDate, inSameDayAs: today)
        }
        let totalCaffeine = filteredList.reduce(0) { $0 + $1.caffeine }
        return totalCaffeine
    }
    
    func numberOfBeveragesForToday() -> Int {
        let calendar = Calendar.current
        let today = Date()
        let filteredList = selectedBeverages.filter {
            calendar.isDate($0.registerDate, inSameDayAs: today)
        }
        return filteredList.count
    }
    
    
}

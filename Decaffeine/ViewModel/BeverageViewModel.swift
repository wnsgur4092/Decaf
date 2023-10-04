//
//  BeverageViewModel.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 2/10/2023.
//

import Foundation
import RealmSwift

class BeverageViewModel: ObservableObject {
    private var realm: Realm
    @Published var allBeverages: [Beverage] = []

    init() {
        realm = try! Realm()
        fetchAllBeverages()
    }
    
    func fetchAllBeverages() {
        allBeverages = []
        allBeverages.append(contentsOf: realm.objects(Coffee.self).map { $0 as Beverage })
        allBeverages.append(contentsOf: realm.objects(Tea.self).map { $0 as Beverage })
        allBeverages.append(contentsOf: realm.objects(Drink.self).map { $0 as Beverage })
    }

    
    func addCoffee(name: String) {
        let coffee = Coffee()
        coffee.name = name
        
        try! realm.write {
            realm.add(coffee)
        }
        
        fetchAllBeverages()
    }
    
    func addTea(name: String){
        let tea = Tea()
        tea.name = name
        
        try! realm.write {
            realm.add(tea)
        }
        
        fetchAllBeverages()
    }
}

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
    private var tokens: [NotificationToken] = [] // Notification tokens array to hold our observation

    // This will be the data source for your views.
    @Published var beverages: [Beverage] = []

    private var beverageResults: Results<Beverage>!

    init() {
        realm = try! Realm()
        print("Realm Path : \(realm.configuration.fileURL?.absoluteURL)")
        addDefaultBeverages()
        setupObservation()
    }

    deinit {
        // Invalidate all notification tokens when the view model deinitializes
        tokens.forEach { $0.invalidate() }
    }

    func setupObservation() {
        beverageResults = realm.objects(Beverage.self)
        
        // Observe Results Notifications
        let token = beverageResults.observe { [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
                self?.loadData()
            case .update(_, let deletions, let insertions, let modifications):
                // Query results have changed, so apply them to the UITableView
                self?.loadData()
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
            }
        }

        tokens.append(token)
    }

    func addItem(name: String, type: String, caffeine: Double) {
        let newBeverage = Beverage(value: ["beverageName": name, "bevereageType": type, "beverageImageName": "", "beverageCaffeine": caffeine])
        
        do {
            try realm.write {
                realm.add(newBeverage)
            }
        } catch let error {
            print("Failed to add new beverage: \(error)")
        }
    }
    
    func addDefaultBeverages() {
        // Check if any beverages already exist
        let existingBeverages = realm.objects(Beverage.self)
        guard existingBeverages.isEmpty else { return }
        
        // Define the default beverages
        let defaultBeverages = [
            //COFFEE
            Beverage(value: ["beverageName": "Latte", "bevereageType": "coffee", "beverageImageName": "", "beverageCaffeine": 0.0]),
            Beverage(value: ["beverageName": "Cappuccino", "bevereageType": "coffee", "beverageImageName": "", "beverageCaffeine": 0.0]),
            
            //TEA
            Beverage(value: ["beverageName": "Black Tea", "bevereageType": "tea", "beverageImageName": "", "beverageCaffeine": 0.0]),
            Beverage(value: ["beverageName": "Green Tea", "bevereageType": "tea", "beverageImageName": "", "beverageCaffeine": 0.0]),
            
            //DRINK
            Beverage(value: ["beverageName": "Cola", "bevereageType": "drink", "beverageImageName": "", "beverageCaffeine": 0.0])
        ]
        
        // Add them to the Realm database
        do {
            try realm.write {
                realm.add(defaultBeverages)
            }
        } catch let error {
            print("Failed to add default beverages: \(error)")
        }
    }
    
    func loadData() {
        beverages = Array(realm.objects(Beverage.self))
    }
}

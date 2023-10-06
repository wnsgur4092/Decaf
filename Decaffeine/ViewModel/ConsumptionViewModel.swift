//
//  ConsumptionViewModel.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 5/10/2023.
//

import Foundation
import RealmSwift

class ConsumptionViewModel: ObservableObject {
    private var realm: Realm
    private var consumptionResults: Results<Consumption>

    @Published var consumptions: [Consumption] = []

    init() {
        realm = try! Realm()
        print("Realm Path : \(realm.configuration.fileURL?.absoluteURL)")
        consumptionResults = realm.objects(Consumption.self)
    }

    func saveConsumption(date: Date, name: String, tag: String, shot: Double, caffeine: Double) {
        let consumption = Consumption()

        consumption.date = date
        consumption.beverageName = name
        consumption.beverageTag = tag
        consumption.shot = Int(shot)
        consumption.caffeine = Int(caffeine)

        do {
            try realm.write {
                realm.add(consumption)
            }
        } catch let error {
            print("Failed to save consumption: \(error)")
        }
    }

    func loadData() {
        consumptions = Array(consumptionResults)
    }

    // Add any other utility functions here as required.
}

//
//  BeverageListViewModel.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 17/2/2023.
//

import Foundation
import RealmSwift
import Combine
import SwiftUI

class HomeViewModel : ObservableObject {
    
    @Published var coffees : [CoffeeModel] = []
    
    var subscription = Set<AnyCancellable>()
    
    init() {
        
        getCoffeeData()
        print("---> Realm Data File Location :\(Realm.Configuration.defaultConfiguration.fileURL!)")
//        bind()
        
    }
    
    func getCoffeeData() {
        guard let realm = try? Realm() else {return}
        
        let savedCoffee = realm.objects(CoffeeModel.self)
        
        try! realm.write{
            self.coffees = savedCoffee.compactMap({$0})
        }
    }
    
//    private func bind(){
//        $coffees.sink { items in
//            print("---> List Changed : \(items)")
//            self.dic = Dictionary(grouping: items, by: {$0.colorCategory})
//            print("dic = \(self.dic)")
//        }
//        .store(in: &subscription)
//    }
}

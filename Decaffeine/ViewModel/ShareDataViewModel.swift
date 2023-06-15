//
//  ShareDataViewModel.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 26/2/2023.
//

import Foundation
import Combine
import SwiftUI
import RealmSwift


class ShareDataViewModel : ObservableObject {
    @Published var selectedBeverages : [SelectedBeverage] = []
    @Published var selectedBeverage : SelectedBeverage = SelectedBeverage()
    @Published var currentDay : Date = Date()
    
    @Published var name : String = ""
    @Published var imageName : String = ""
    @Published var numberOfShots : Double = 0.5
    @Published var size : String = ""
    @Published var registerDate : Date = Date()
    @Published var selectedSize: String?
    @Published var caffeine : Double = 0.0
    
    let caffeinePerShot : Double = 63 // ex) 63mg -> static 카페인 1shot 당 함량
    @Published var totalCaffeine : Double = 0 // NumberOfShots * caffeinePerShot = totalCaffeine
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        
        self.selectedBeverages = selectedBeverages
        
        
        $name.sink { name in
            print(">>> Selected name : \(name)")
            self.updateBeverageName(name: name)
        }.store(in: &subscriptions)
        
        $imageName.sink { imageName in
            print(">>> Selected imageName : \(imageName)")
            self.updateBeverageImageName(imageName: imageName)
        }.store(in: &subscriptions)
        
        $numberOfShots.sink { numberOfShots in
            print(">>> Selected numberOfShots : \(numberOfShots)")
            self.updateBeverageShots(numberOfShots: numberOfShots)
        }.store(in: &subscriptions)
        
        $size.sink { size in
            print(">>> Selected size : \(size)")
            self.updateBeverageSize(size: size)
        }.store(in: &subscriptions)
        
        $registerDate.sink { registerDate in
            print(">>> Selected registerDate : \(registerDate)")
            self.updateBeverageRegisterDate(registerDate: registerDate)
        }.store(in: &subscriptions)
        
        $caffeine.sink { caffeine in
            self.updateCaffeine(caffeine: caffeine)
        }.store(in: &subscriptions)
        
    }
    
    func updateCaffeine(caffeine : Double) {
        self.selectedBeverage.caffeine = totalCaffeine // observeCaffeine 메서드를 호출하여 totalCaffeine 값을 계산 및 업데이트합니다.
    }
    
    func updateBeverageName(name: String) {
        self.selectedBeverage.name = name
    }
    
    func updateBeverageImageName(imageName: String){
        self.selectedBeverage.imageName = imageName
    }
    
    func updateBeverageShots(numberOfShots: Double) {
        self.selectedBeverage.numberOfShots = numberOfShots
        updateTotalCaffeine() // totalCaffeine 값을 다시 계산합니다.
    }
    
    func updateBeverageSize(size: String) {
        self.selectedBeverage.size = size
        self.selectedSize = size
    }
    
    func updateBeverageRegisterDate(registerDate: Date) {
        self.selectedBeverage.registerDate = registerDate
    }
    
    func updateTotalCaffeine() {
        self.totalCaffeine = self.selectedBeverage.numberOfShots * self.caffeinePerShot
        updateCaffeine(caffeine: self.totalCaffeine) // caffeine 값을 다시 업데이트합니다.
    }
}

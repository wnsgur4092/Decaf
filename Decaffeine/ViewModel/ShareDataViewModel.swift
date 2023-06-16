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
    //MARK: - PROPERTIES
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
    
    //MARK: - INIT
    init() {
    
        fetchSelectedBeverages(for: currentDay)
        print("---> Realm Data File Location :\(Realm.Configuration.defaultConfiguration.fileURL!)")
        
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
    
    //MARK: - COMBINE
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
    }
    
    func updateBeverageRegisterDate(registerDate: Date) {
        self.selectedBeverage.registerDate = registerDate
    }
    
    func updateTotalCaffeine() {
        self.totalCaffeine = self.selectedBeverage.numberOfShots * self.caffeinePerShot
        updateCaffeine(caffeine: self.totalCaffeine) // caffeine 값을 다시 업데이트합니다.
    }
    
    //MARK: - Beverage INPUT VIEW
    func saveData() {
        guard let realm = try? Realm() else { return }

        selectedBeverage.registerDate = Date()
        print("---> current time: \(selectedBeverage.registerDate)")
        selectedBeverages.append(selectedBeverage) // Append directly to selectedBeverages
            
        do {
            try realm.write {
                realm.add(selectedBeverage)
            }
        } catch let error {
            print("!!!! BeverageInputView realm error : \(error)")
        }
    }

    
    //MARK: - HOME VIEW
    func fetchSelectedBeverages(for day: Date) {
        guard let realm = try? Realm() else {return}
        
        let selectedBeverage = realm.objects(SelectedBeverage.self)
        
        try! realm.write{
            self.selectedBeverages = selectedBeverage.filter { Calendar.current.isDate($0.registerDate, inSameDayAs: day) }
        }
    }
    
    func numberOfBeveragesForToday() -> Int {
        let calendar = Calendar.current
        let today = Date()
        let filteredList = selectedBeverages.filter {
            calendar.isDate($0.registerDate, inSameDayAs: today)
        }
        return filteredList.count
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
    
    //MARK: - ARCHIVE VIEW
    
    func formatYear(year: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy" // Day of month
        return dateFormatter.string(from: year)
    }
    
    func formatMonth(month: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "MMMM" // Full month name
        return dateFormatter.string(from: month)
    }
    
    func fetchCurrentMonth() -> String {
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: today)
    }
    
    func formatTime(time : Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "HH:mm" // Day of month
        return dateFormatter.string(from: time)
    }
}

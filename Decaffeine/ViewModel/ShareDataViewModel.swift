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
import SwiftUICalendar


class ShareDataViewModel : ObservableObject {
    //MARK: - PROPERTIES
    @Published var selectedBeverages : [SelectedBeverage] = []
    @Published var selectedBeverage : SelectedBeverage = SelectedBeverage()
    
    @Published var currentDay : Date = Date()
    @Published var name : String = ""
    @Published var imageName : String = ""
    @Published var numberOfShots : Double = 0.5
    @Published var size : String = "Small"
    @Published var registerDate : Date = Date()
    @Published var caffeine : Double = 0.0
    @Published var color : String = ""
    
    @Published var isPopoverPresented : Bool = false
    @Published var isArchiveViewShowing : Bool = false
    
    let caffeinePerShot : Double = 63 // ex) 63mg -> static 카페인 1shot 당 함량
    let maximumCaffeinePerDay : Double = 400
    @Published var totalCaffeine : Double = 0 // NumberOfShots * caffeinePerShot = totalCaffeine
    
    @Published var hasNewData: Bool = false
    
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
        
        $color.sink { color in
            self.updateColor(color: color)
        }.store(in: &subscriptions)
        
    }
    
    //MARK: - COMBINE
    func updateCaffeine(caffeine : Double) {
        do {
            let realm = try Realm()
            try realm.write {
                self.selectedBeverage.caffeine = caffeine
            }
        } catch let error {
            print("Error updating caffeine: \(error)")
        }
    }

    
    func updateBeverageName(name: String) {
        do {
            let realm = try Realm()
            try realm.write {
                self.selectedBeverage.name = name
            }
        } catch let error {
            print("Error updating name: \(error)")
        }
    }
        
    func updateBeverageImageName(imageName: String){
        do {
            let realm = try Realm()
            try realm.write {
                self.selectedBeverage.imageName = imageName
            }
        } catch let error {
            print("Error updating image name: \(error)")
        }
    }
        
    func updateBeverageShots(numberOfShots: Double) {
        do {
            let realm = try Realm()
            try realm.write {
                self.selectedBeverage.numberOfShots = numberOfShots
            }
        } catch let error {
            print("Error updating number of shots: \(error)")
        }
    }
        
    func updateBeverageSize(size: String) {
        do {
            let realm = try Realm()
            try realm.write {
                self.selectedBeverage.size = size
            }
        } catch let error {
            print("Error updating size: \(error)")
        }
    }
        
    func updateBeverageRegisterDate(registerDate: Date) {
        do {
            let realm = try Realm()
            try realm.write {
                self.selectedBeverage.registerDate = registerDate
            }
        } catch let error {
            print("Error updating register date: \(error)")
        }
    }
    
    func updateColor(color: String){
        do {
            let realm = try Realm()
            try realm.write {
                self.selectedBeverage.color = color
            }
        } catch let error {
            print("Error updating color: \(error)")
        }
    }
    
    
    //MARK: - Beverage INPUT VIEW
    func saveData() {
        print("Saving data: \(selectedBeverage.name), \(selectedBeverage.imageName), \(selectedBeverage.numberOfShots), \(selectedBeverage.size), \(selectedBeverage.caffeine), \(selectedBeverage.color)")
        guard let realm = try? Realm() else { return }
        
        let newBeverage = SelectedBeverage()  // Create a new SelectedBeverage instance
        newBeverage.name = selectedBeverage.name
        newBeverage.imageName = selectedBeverage.imageName
        newBeverage.numberOfShots = selectedBeverage.numberOfShots
        newBeverage.size = selectedBeverage.size
        newBeverage.caffeine = selectedBeverage.numberOfShots * caffeinePerShot
        newBeverage.registerDate = Date()
        newBeverage.color = selectedBeverage.color

        print("---> current time: \(newBeverage.registerDate)")
        selectedBeverages.append(newBeverage) // Append directly to selectedBeverages
        
        do {
            try realm.write {
                realm.add(newBeverage)
            }
        } catch let error {
            print("!!!! BeverageInputView realm error : \(error)")
        }
        fetchSelectedBeverages(for: currentDay)
        hasNewData = true
    }

    
    
    //MARK: - HOME VIEW
    func fetchSelectedBeverages(for day: Date) {
        guard let realm = try? Realm() else {return}

        let selectedBeverage = realm.objects(SelectedBeverage.self)
        let beverages = selectedBeverage.filter { Calendar.current.isDate($0.registerDate, inSameDayAs: day) }

        self.selectedBeverages = Array(beverages)
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
  
    func totalCaffeineForDay(date: Date) -> Double {
        let startOfDay = Calendar.current.startOfDay(for: date)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let filteredList = selectedBeverages.filter {
            $0.registerDate >= startOfDay && $0.registerDate < endOfDay
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
    

    
    
    var beverageCaffeineSum: [YearMonthDay: Double] {
        var sums = [YearMonthDay: Double]()
        for beverage in selectedBeverages {
            let date = beverage.registerDate
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: date)
            let year = components.year!
            let month = components.month!
            let day = components.day!
            let ymd = YearMonthDay(year: year, month: month, day: day)
            
            if sums[ymd] != nil {
                sums[ymd]! += beverage.caffeine // assuming 'caffeine' is a Double property in your Beverage struct
            } else {
                sums[ymd] = beverage.caffeine
            }
        }
        return sums
    }
    

}

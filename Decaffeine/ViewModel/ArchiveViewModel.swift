import Foundation
import SwiftUI
import RealmSwift
import Combine

class ArchiveViewModel : ObservableObject {
    //MARK: - PROPERTIES
    
    @Published var currentWeek : [Date] = [] //Current Week Days
    @Published var currentDay : Date = Date()
    @Published var selectedBeverages: [SelectedBeverage] = []
    
    var notificationToken: NotificationToken? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - INTIAL
    init() {
        guard let realm = try? Realm() else {
            // handle error
            return
        }
        
        fetchCurrentWeek()
        observeSelectedBeverages()
        fetchSelectedBeverages(for: currentDay)
        
        notificationToken = realm.objects(SelectedBeverage.self).observe { [weak self] changes in
            guard let self = self else { return }
            switch changes {
            case .initial:
                self.loadSelectedBeverages()
            case .update(_, let deletions, _, _):
                deletions.forEach { index in
                    self.selectedBeverages.remove(at: index)
                    self.objectWillChange.send()
                }
            case .error(let error):
                print("Error: \(error)")
            }
        }
    }


    
    //MARK: - FUNCTION
    
    func observeSelectedBeverages() {
        guard let realm = try? Realm() else {
            return
        }
        notificationToken = realm.objects(SelectedBeverage.self).observe { [weak self] changes in
            guard let self = self else { return }
            switch changes {
            case .initial:
                self.loadSelectedBeverages()
            case .update(_, let deletions, let insertions, let modifications):
                self.selectedBeverages.enumerated().forEach { (index, element) in
                    if deletions.contains(index) {
                        self.selectedBeverages.remove(at: index)
                    }
                }
                insertions.forEach { index in
                    self.selectedBeverages.insert(realm.objects(SelectedBeverage.self)[index], at: index)
                }
                modifications.forEach { index in
                    self.selectedBeverages[index] = realm.objects(SelectedBeverage.self)[index]
                }
            case .error(let error):
                print("Error: \(error)")
            }
        }
    }


    
    func fetchSelectedBeverages(for date: Date) {
        let realm = try! Realm()
        let startOfDay = Calendar.current.startOfDay(for: date)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let selectedBeverages = Array(realm.objects(SelectedBeverage.self).filter("registerDate >= %@ AND registerDate < %@", startOfDay, endOfDay).sorted(byKeyPath: "registerDate", ascending: false))
        self.selectedBeverages = selectedBeverages
        self.objectWillChange.send() // 뷰에 변경이 있음을 알림
    }
    
    
    
    func deleteBeverage(day: Date, name: String) {
        let realm = try! Realm()
        let startOfDay = Calendar.current.startOfDay(for: day)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        
        // Search for the beverage to delete
        if let beverageToDelete = realm.objects(SelectedBeverage.self).filter("registerDate >= %@ AND registerDate < %@ AND name = %@", startOfDay, endOfDay, name).first {
            try! realm.write {
                realm.delete(beverageToDelete)
                if let index = selectedBeverages.firstIndex(where: { $0.id == beverageToDelete.id }) {
                    selectedBeverages.remove(at: index)
                    self.objectWillChange.send()
                }
            }
        }
    }

    func loadSelectedBeverages() {
        let realm = try! Realm()
        selectedBeverages = Array(realm.objects(SelectedBeverage.self).filter("registerDate >= %@ AND registerDate < %@", Calendar.current.startOfDay(for: currentDay), Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: currentDay))!).sorted(byKeyPath: "registerDate", ascending: false))
    }
    
    
    
    func fetchCurrentMonth() -> String {
        let _ = Calendar.current
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: today)
    }
    
    
    
    func totalCaffeineForToday() -> Int {
        let calendar = Calendar.current
        let today = Date()
        let filteredList = selectedBeverages.filter {
            calendar.isDate($0.registerDate, inSameDayAs: today)
        }
        let totalCaffeine = filteredList.reduce(0) { $0 + $1.caffeine }
        return totalCaffeine
    }
    
    
    func fetchCurrentWeek(){
        
        let today = Date()
        let calendar = Calendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else{
            return
        }
        
        (0..<7).forEach { day in
            
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay){
                currentWeek.append(weekday)
            }
        }
    }
    
    //Extract Date
    func formatDate(day: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "EEE" // Abbreviated weekday name
        return dateFormatter.string(from: day)
    }
    
    //EXtract Day
    func formatDay(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "dd" // Day of month
        return dateFormatter.string(from: date)
    }
    
    func formatMonth(month: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "MMM" // Day of month
        return dateFormatter.string(from: month)
    }
    
    func formatTime(time : Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "HH:mm" // Day of month
        return dateFormatter.string(from: time)
    }
    
    
    //Check Current Day is Today
    func isToday(date: Date)->Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(currentDay, inSameDayAs: date)
    }
    
    
}


import Foundation
import SwiftUI
import Combine
import RealmSwift


class ArchiveViewModel : ObservableObject {
    //MARK: - PROPERTIES
    
    
    
    @Published var selectedBeverages : [SelectedBeverage] = []
    @Published var selectedBeverage = SelectedBeverage()
    
    @Published var currentWeek : [Date] = [] //Current Week Days
    @Published var currentDay : Date = Date()
    
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - INTIAL
    init() {
        
        
        self.currentDay = Date()
        
        fetchCurrentWeek()
        fetchSelectedBeverages(for: currentDay)
        
        NotificationCenter.default
            .publisher(for: .beverageUpdated)
            .sink(receiveValue : { _ in

                self.fetchSelectedBeverages(for: self.currentDay)
            })
            .store(in: &cancellables)
        
    }
    
    //MARK: - FUNCTION
    
    func fetchSelectedBeverages(for day: Date) {
        guard let realm = try? Realm() else {return}
        
        let selectedBeverage = realm.objects(SelectedBeverage.self)
        let selectedBeveragesForDay = selectedBeverage.filter { Calendar.current.isDate($0.registerDate, inSameDayAs: day) }
        
        self.selectedBeverages = Array(selectedBeveragesForDay)
    }
    
    func deleteData(selectedBeverage: SelectedBeverage) {
        guard let realm = try? Realm() else { return }
        
        if let selectedBeverage = realm.objects(SelectedBeverage.self).filter("id == %@", selectedBeverage.id).first {
            do {
//                if let index = selectedBeverages.firstIndex(where: { $0.id == selectedBeverage.id }) {
//                    selectedBeverages.remove(at: index)
//                }
//
                try realm.write {
                    realm.delete(selectedBeverage)
                }

                fetchSelectedBeverages(for: currentDay)
            } catch let error {
                print("!!!! ArchiveViewModel realm error : \(error)")
            }
        }
    }
    
    
    
    
    
    func fetchCurrentMonth() -> String {
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: today)
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
    func extraDate()->[String]{
        
        let calendar = Calendar.current
        let month = calendar.component(.month, from: currentDay) - 1
        let year = calendar.component(.year, from: currentDay)
        
        return ["\(year)",calendar.monthSymbols[month]]
    }
    
    func isSameDay(date1: Date,date2: Date)->Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    // 해당 월의 일(day)들을 반환하는 함수
    func getDaysOfMonth(month: Date) -> [Date] {
        let calendar = Calendar.current
        let monthInterval = calendar.dateInterval(of: .month, for: month)!
        let start = monthInterval.start
        let end = monthInterval.end
        
        var date = start
        var daysOfMonth: [Date] = []
        
        while date <= end {
            daysOfMonth.append(date)
            date = calendar.date(byAdding: .day, value: 1, to: date)!
        }
        
        return daysOfMonth
    }

    
    //Extract Date
    func formatDate(day: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "EEE" // Abbreviated weekday name
        return dateFormatter.string(from: day)
    }
    
    //EXtract Day
    func formatDay(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "dd" // Day of month
        return dateFormatter.string(from: date)
    }
    
    func previousMonth() {
        guard let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: currentDay) else {
            return
        }
        currentDay = previousMonth
        fetchSelectedBeverages(for: currentDay)
    }

    func nextMonth() {
        guard let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: currentDay) else {
            return
        }
        currentDay = nextMonth
        fetchSelectedBeverages(for: currentDay)
    }

    func formatMonth(month: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "MMMM" // Full month name
        return dateFormatter.string(from: month)
    }

    
    func formatYear(year: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "yyyy" // Day of month
        return dateFormatter.string(from: year)
    }
    
    func formatTime(time : Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "HH:mm" // Day of month
        return dateFormatter.string(from: time)
    }
    
    
    //Check Current Day is Today
    func isToday(date: Date)->Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(currentDay, inSameDayAs: date)
    }
    
    
}


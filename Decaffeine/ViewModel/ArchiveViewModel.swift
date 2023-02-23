import Foundation
import SwiftUI
import Combine

class ArchiveViewModel : ObservableObject {
    //MARK: - PROPERTIES
    
    let storage : SelectedBeverageStroage
    
    @Published var list: [SelectedBeverage] = []
    @Published var dic : [String: [SelectedBeverage]] = [:]
    
    @Published var currentWeek : [Date] = [] //Current Week Days
    @Published var currentDay : Date = Date()
    
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - INTIAL
    init(storage: SelectedBeverageStroage) {
        self.storage = storage
        self.currentDay = Date()
        
        fetchCurrentWeek()
        fetchSelectedBeverages(for: currentDay)
        
        storage.$selectedBeverages
              .sink { [weak self] _ in
                  guard let self = self else { return }
                  self.fetchSelectedBeverages(for: self.currentDay)
              }
              .store(in: &cancellables)
    }
    
    //MARK: - FUNCTION
    
    func fetchSelectedBeverages(for day: Date) {
        self.list = storage.fetch().filter { Calendar.current.isDate($0.registerDate, inSameDayAs: day) }

    }
    
    func delete() {
        
    }
    
    func fetchCurrentMonth() -> String {
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: today)
    }
    
    func totalCaffeineForToday() -> Int {
        let calendar = Calendar.current
        let today = Date()
        let filteredList = list.filter {
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


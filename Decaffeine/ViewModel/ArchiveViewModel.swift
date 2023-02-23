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
        
    }
    
    //MARK: - FUNCTION
    
    func fetchSelectedBeverages(for day: Date) {
        guard let realm = try? Realm() else {return}
        
        let selectedBeverage = realm.objects(SelectedBeverage.self)
        
        try! realm.write{
            self.selectedBeverages = selectedBeverage.filter { Calendar.current.isDate($0.registerDate, inSameDayAs: day) }
        }
    }
    
    func deleteData(selectedBeverage: SelectedBeverage) {
        guard let realm = try? Realm() else { return }

        if let selectedBeverage = realm.objects(SelectedBeverage.self).filter("id == %@", selectedBeverage.id).first {
            do {
                try realm.write {
                    realm.delete(selectedBeverage)
                }
                // 객체를 Realm에서 삭제한 후에 배열에서 제거합니다.
                if let index = selectedBeverages.firstIndex(where: { $0.id == selectedBeverage.id }) {
                    selectedBeverages.remove(at: index)
                }
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


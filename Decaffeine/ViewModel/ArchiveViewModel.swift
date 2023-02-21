import Foundation
import SwiftUI
import RealmSwift
import Combine

class ArchiveViewModel : ObservableObject {
    //MARK: - PROPERTIES
    
    @Published var currentWeek : [Date] = [] //Current Week Days
    @Published var currentDay : Date = Date()
    @Published var selectedBeverages: [SelectedBeverage] = []

    private var cancellables = Set<AnyCancellable>()

    //MARK: - INTIAL
    init() {
        fetchCurrentWeek()
        fetchSelectedBeverages(for: currentDay) // 선택한 날짜에 해당하는 음료 불러오기
    }
    
    //MARK: - FUNCTION

    func fetchSelectedBeverages(for date: Date) {
        let realm = try! Realm()
        let startOfDay = Calendar.current.startOfDay(for: date)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        
        // Use `Future` to make the method asynchronous
        let futureSelectedBeverages = Future<[SelectedBeverage], Error> { promise in
            let selectedBeverages = Array(realm.objects(SelectedBeverage.self).filter("registerDate >= %@ AND registerDate < %@", startOfDay, endOfDay).sorted(byKeyPath: "registerDate", ascending: false))
            promise(.success(selectedBeverages))
        }

        // Subscribe to the future and update `selectedBeverages` when it completes
        futureSelectedBeverages.receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] selectedBeverages in
                      self?.selectedBeverages = selectedBeverages
                      self?.objectWillChange.send() // 뷰에 변경이 있음을 알림
                  })
            .store(in: &cancellables)
    }
    
    func loadSelectedBeverages() {
          let realm = try! Realm()
          selectedBeverages = Array(realm.objects(SelectedBeverage.self).filter("registerDate >= %@ AND registerDate < %@", Calendar.current.startOfDay(for: currentDay), Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: currentDay))!).sorted(byKeyPath: "registerDate", ascending: false))
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

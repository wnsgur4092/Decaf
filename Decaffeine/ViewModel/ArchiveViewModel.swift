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
        fetchSelectedBeverages(for: currentDay)
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
                  })
            .store(in: &cancellables)
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
        dateFormatter.dateFormat = "d" // Day of month
        return dateFormatter.string(from: date)
    }
    
    //Check Current Day is Today
    func isToday(date: Date)->Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(currentDay, inSameDayAs: date)
    }
    

}

//
//  ArchiveViewModel.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 16/2/2023.
//

import Foundation
import SwiftUI

class ArchiveViewModel : ObservableObject {
    //MARK: - PROPERTIES
    
    
    @Published var currentWeek : [Date] = [] //Current Week Days
    @Published var currentDay : Date = Date()
    
    //MARK: - INTIAL
    init() {
        fetchCurrentWeek()
    }
    
    //MARK: - FUNCTION
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

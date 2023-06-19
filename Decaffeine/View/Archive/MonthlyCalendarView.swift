//
//  MonthlyCalendarView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 17/6/2023.
//

import SwiftUI

struct MonthlyCalendarView: View {
    @EnvironmentObject var sharedDataViewModel: ShareDataViewModel
    @State private var currentMonth = Date()

    var body: some View {
        VStack {
            // Navigation
            HStack {
                Button(action: { self.currentMonth = Calendar.current.date(byAdding: .month, value: -1, to: self.currentMonth) ?? self.currentMonth }) {
                    Image(systemName: "chevron.left")
                }
                Spacer()
                Text("\(sharedDataViewModel.formatMonth(month: currentMonth)) \(sharedDataViewModel.formatYear(year: currentMonth))")
                Spacer()
                Button(action: { self.currentMonth = Calendar.current.date(byAdding: .month, value: 1, to: self.currentMonth) ?? self.currentMonth }) {
                    Image(systemName: "chevron.right")
                }
            }
  
            
            
            // Grid of Days
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                // Weekday Headers
                ForEach(["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"], id: \.self) { day in
                    Text(day)
                }
                .padding(.vertical, 20)

                ForEach(getDaysInMonth(), id: \.self) { date in
                    VStack {
                        Text("\(Calendar.current.component(.day, from: date))")
                        if sharedDataViewModel.totalCaffeineForDay(date: date) > sharedDataViewModel.maximumCaffeinePerDay {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 10, height: 10)
                        } else {
                            Circle()
                                .fill(Color.green)
                                .frame(width: 10, height: 10)
                        }
                    }
                }
            }
        }
    }

    func getDaysInMonth() -> [Date] {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: currentMonth)!
        
        return range.map { day -> Date in
            var components = DateComponents()
            components.year = calendar.component(.year, from: currentMonth)
            components.month = calendar.component(.month, from: currentMonth)
            components.day = day
            
            return calendar.date(from: components)!
        }
    }
}

struct MonthlyCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyCalendarView()
            .environmentObject(ShareDataViewModel())
    }
}

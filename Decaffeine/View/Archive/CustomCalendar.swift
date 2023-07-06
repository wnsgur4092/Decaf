//
//  CustomCalendar.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 20/6/2023.
//

import SwiftUI

struct CustomCalendar: View {
    //MARK: - PROPERTIES
    @EnvironmentObject var sharedDataViewModel : ShareDataViewModel
    @Binding var currentDate: Date
    // Month update on arrow button clicks...
    @State var currentMonth: Int = 0
    @State private var isDetailViewPresented = false
    @State private var selectedBeverage: SelectedBeverage? = nil
    
    
    
    //MARK: - BODY
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20){
                // Days...
                let days: [String] = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
                
                HStack(spacing: 20){
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text(extraDate()[0])
                            .font(.caption)
                            .fontWeight(.semibold)
                        
                        Text(extraDate()[1])
                            .font(.title.bold())
                    }
                    
                    Spacer(minLength: 0)
                    
                    Button {
                        withAnimation{
                            currentMonth -= 1
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                    }
                    
                    Button {
                        
                        withAnimation{
                            currentMonth += 1
                        }
                        
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.title2)
                    }
                }
                .padding(.horizontal)
                // Day View...
                
                
                HStack(spacing: 0){
                    ForEach(days,id: \.self){day in
                        
                        Text(day)
                            .font(.callout)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                    }
                }
                
                // Dates....
                // Lazy Grid..
                let columns = Array(repeating: GridItem(.flexible()), count: 7)
                
                LazyVGrid(columns: columns,spacing: 15) {
                    
                    ForEach(extractDate()){value in
                        
                        CardView(value: value)
                            .background(
                                
                                Capsule()
                                    .fill(Color("Pink"))
                                    .padding(.horizontal,8)
                                    .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                            )
                            .onTapGesture {
                                currentDate = value.date
                            }
                    }
                }
                
                Divider()
                
                VStack(spacing: 15){
                    totalCaffeine
                    
                    timeLineHeader
                    
                    archiveListView
                }
                .padding()
            }
            .onChange(of: currentMonth) { newValue in
                
                // updating Month...
                currentDate = getCurrentMonth()
            }
        }
        .padding(.horizontal, 12)
        
    }
    
    //MARK: - COMPONENT
    
    fileprivate var timeLineHeader : some View {
        HStack {
            Text("Time")
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .opacity(0.4)
                .frame(alignment: .leading)
                .padding(.trailing, 50)
            
            Text("Beverage")
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .opacity(0.4)
                .frame(maxWidth: .infinity,
                       alignment: .leading)
    
        }
    }
    
    
    fileprivate var totalCaffeine : some View {
        HStack(alignment: .center){
            Text("Total Caffeine")
                .font(.system(size: 24).bold())
            
            Spacer()
            
            HStack{
                
                let caffeineForCurrentDate = sharedDataViewModel.totalCaffeineForDay(date: currentDate)
                Text(String(format: "%.1f", caffeineForCurrentDate))
                    .foregroundColor(caffeineForCurrentDate > 400 ? Color.red : Color("mainColor"))

                
                Text("/ 400mg")
            }
            .font(.system(size: 16))
            .padding(12)
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 1))
            
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue)->some View{
        VStack{
            if value.day != -1{
                
                // Get all beverages for the current date
                let beveragesForTheDay = sharedDataViewModel.selectedBeverages.filter { isSameDay(date1: $0.registerDate, date2: value.date) }
                
                if let beverage = beveragesForTheDay.first {
                    Text("\(value.day)")
                        .font(.callout.bold())
                        .foregroundColor(isSameDay(date1: beverage.registerDate, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                    if beveragesForTheDay.count > 0 {
                        Circle()
                            .fill(isSameDay(date1: beverage.registerDate, date2: currentDate) ? .white : Color("Pink"))
                            .frame(width: 8,height: 8)
                    }
                }
                else{
                    
                    Text("\(value.day)")
                        .font(.callout.bold())
                        .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                }
            }
        }
        .padding(.vertical,9)
        .frame(height: 60,alignment: .top)
    }

    fileprivate var archiveListView: some View {
        ForEach(sharedDataViewModel.selectedBeverages.filter({ isSameDay(date1: $0.registerDate, date2: currentDate) }), id: \.id) { beverage in
            VStack(spacing: 10) {
                HStack(alignment: .top, spacing: 5) {
                    Text(sharedDataViewModel.formatTime(time: beverage.registerDate))
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                        .offset(y: 4)
                        .frame(maxWidth: 80, alignment: .topLeading)
                    
                    Button(action: {
                        selectedBeverage = beverage
                        isDetailViewPresented = true
                    }) {
                        HStack {
                            VStack{
                                Text(beverage.name)
                                    .font(.system(size: 14).bold())
                                    .foregroundColor(Color.white)
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.bottom, 16)
                                Text(beverage.size)
                                    .font(.system(size: 12))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color.white)
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.bottom, 5)
                                Text("\(String(format: "%.1f", beverage.numberOfShots)) Shots")
                                    .font(.system(size: 12))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color.white)
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.white)
                        }
                        .padding(15)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color("mainColor")))
                    }
                    .fullScreenCover(isPresented: $isDetailViewPresented, content: {
                        ArchiveListDetailView(beverageName: beverage.name, beverageImage: beverage.imageName, beverageRegisterDate: beverage.registerDate, beverageShots: beverage.numberOfShots , beverageCaffeine: beverage.caffeine , beverageSize: beverage.size, viewModel: ArchiveViewModel())

                    })
                }
            }
        }
    }

    

//    fileprivate var archiveListView: some View {
//        ForEach(sharedDataViewModel.selectedBeverages.filter({ isSameDay(date1: $0.registerDate, date2: currentDate) }), id: \.id) { beverage in
//            VStack(spacing: 10) {
//                HStack(alignment: .top, spacing: 5) {
//                    Text(sharedDataViewModel.formatTime(time: beverage.registerDate))
//                        .font(.subheadline)
//                        .multilineTextAlignment(.leading)
//                        .offset(y: 4)
//                        .frame(maxWidth: 80, alignment: .topLeading)
//
//                    Button(action: {
//                        selectedBeverage = beverage
//                        isDetailViewPresented = true
//                    }) {
//                        HStack {
//                            VStack{
//                                Text(beverage.name)
//                                    .font(.system(size: 14).bold())
//                                    .foregroundColor(Color.white)
//                                    .multilineTextAlignment(.leading)
//                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                    .padding(.bottom, 16)
//                                Text(beverage.size)
//                                    .font(.system(size: 12))
//                                    .fontWeight(.regular)
//                                    .foregroundColor(Color.white)
//                                    .multilineTextAlignment(.leading)
//                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                    .padding(.bottom, 5)
//                                Text("\(String(format: "%.1f", beverage.numberOfShots)) Shots")
//                                    .font(.system(size: 12))
//                                    .fontWeight(.regular)
//                                    .foregroundColor(Color.white)
//                                    .multilineTextAlignment(.leading)
//                                    .frame(maxWidth: .infinity, alignment: .leading)
//                            }
//                            Spacer()
//                            Image(systemName: "chevron.right")
//                                .foregroundColor(.white)
//                        }
//                        .padding(15)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .background(RoundedRectangle(cornerRadius: 20).fill(Color("mainColor")))
//                    }
//                    .fullScreenCover(isPresented: $isDetailViewPresented, content: {
//                        ArchiveListDetailView(beverageName: beverage.name, beverageImage: beverage.imageName, beverageRegisterDate: beverage.registerDate, beverageShots: beverage.numberOfShots, beverageCaffeine: beverage.caffeine, beverageSize: beverage.size, viewModel: ArchiveViewModel())
//                    })
//                }
//            }
//        }
//    }
    
    
    //MARK: - FUNCTION
    // checking dates...
    func isSameDay(date1: Date,date2: Date)->Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    // extrating Year And Month for display...
    func extraDate()->[String]{
        
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "en_US")
        let month = calendar.component(.month, from: currentDate) - 1
        let year = calendar.component(.year, from: currentDate)
        
        return ["\(year)",calendar.monthSymbols[month]]
    }
    
    func getCurrentMonth()->Date{
        
        let calendar = Calendar.current
        
        // Getting Current Month Date....
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else{
            return Date()
        }
        
        return currentMonth
    }
    
    func extractDate()->[DateValue]{
        
        let calendar = Calendar.current
        
        // Getting Current Month Date....
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            
            // getting day...
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
        
        // adding offset days to get exact week day...
        let firstWeekday = calendar.component(.weekday, from: days.first!.date)
        
        for _ in 0..<firstWeekday - 1{
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
}

struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//MARK: - EXTENSION
// Extending Date to get Current Month Dates...
extension Date{
    
    func getAllDates()->[Date]{
        
        let calendar = Calendar.current
        
        // getting start Date...
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        // getting date...
        return range.compactMap { day -> Date in
            
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}

//MARK: - PREVIEW
struct CustomCalendar_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

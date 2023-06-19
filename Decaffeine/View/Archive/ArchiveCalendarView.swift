//
//  ArchiveCalendarView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 19/6/2023.
//

import SwiftUI
import SwiftUICalendar

struct ArchiveCalendarView: View {
    //MARK: - PROPERTIES
    
    @EnvironmentObject var sharedDataViewMㅋodel : ShareDataViewModel
    let controller = CalendarController()
    @State private var informations = [YearMonthDay: [(String, Color)]]()
    @State var focusDate: YearMonthDay? = nil
    @State var focusInfo: [(String, Color)]? = nil

    var body: some View {
        GeometryReader { reader in
            VStack {
                CalendarView(controller, header: { week in
                    GeometryReader { geometry in
                        Text(week.shortString)
                            .font(.subheadline)
                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                    }
                }, component: { date in
                    GeometryReader { geometry in
                        VStack(alignment: .leading, spacing: 2) {
                            if date.isToday {
                                Text("\(date.day)")
                                    .font(.system(size: 10, weight: .bold, design: .default))
                                    .padding(4)
                                    .foregroundColor(.white)
                                    .background(Color.red.opacity(0.95))
                                    .cornerRadius(14)
                            } else {
                                Text("\(date.day)")
                                    .font(.system(size: 10, weight: .light, design: .default))
                                    .opacity(date.isFocusYearMonth == true ? 1 : 0.4)
                                    .foregroundColor(getColor(date))
                                    .padding(4)
                            }
                            if let infos = informations[date] {
                                ForEach(infos.indices, id: \.self) { index in
                                    let info = infos[index]
                                    if focusInfo != nil {
                                        Rectangle()
                                            .fill(info.1.opacity(0.75))
                                            .frame(width: geometry.size.width, height: 4, alignment: .center)
                                            .cornerRadius(2)
                                            .opacity(date.isFocusYearMonth == true ? 1 : 0.4)
                                    } else {
                                        Text(info.0)
                                            .lineLimit(1)
                                            .foregroundColor(.white)
                                            .font(.system(size: 8, weight: .bold, design: .default))
                                            .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                                            .frame(width: geometry.size.width, alignment: .center)
                                            .background(info.1.opacity(0.75))
                                            .cornerRadius(4)
                                            .opacity(date.isFocusYearMonth == true ? 1 : 0.4)
                                    }
                                }
                            }
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
                        .border(.green.opacity(0.8), width: (focusDate == date ? 1 : 0))
                        .cornerRadius(2)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation {
                                if focusDate == date {
                                    focusDate = nil
                                    focusInfo = nil
                                } else {
                                    focusDate = date
                                    focusInfo = informations[date]
                                }
                            }
                        }
                    }
                })
                if let infos = focusInfo {
                    List(infos.indices, id: \.self) { index in
                        let info = infos[index]
                        HStack(alignment: .center, spacing: 0) {
                            Circle()
                                .fill(info.1.opacity(0.75))
                                .frame(width: 12, height: 12)
                            Text(info.0)
                                .padding(.leading, 8)
                        }
                    }
                    .frame(width: reader.size.width, height: 160, alignment: .center)
                }
            }
        }
        .navigationBarTitle("Info + Select")
        .onAppear(perform: loadData)
    }
    
    //MARK: - FUNCTION

    private func loadData() {
        let beverages = sharedDataViewModel.selectedBeverages
        for beverage in beverages {
            let date = beverage.registerDate
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: date)
            let year = components.year!
            let month = components.month!
            let day = components.day!
            
            let ymd = YearMonthDay(year: year, month: month, day: day)
            let color: Color = Color(beverage.color) // Use color from the Beverage struct
            informations[ymd] = []
            informations[ymd]?.append((beverage.name, color))
        }
    }
    

    private func getColor(_ date: YearMonthDay) -> Color {
        if date.dayOfWeek == .sun {
            return Color.red
        } else if date.dayOfWeek == .sat {
            return Color.blue
        } else {
            return Color.black
        }
    }
}

extension YearMonthDay: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(year)
        hasher.combine(month)
        hasher.combine(day)
    }
}

//MARK: - PREVIEW
struct ArchiveCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        ArchiveCalendarView()
            .environmentObject(ShareDataViewModel())
    }
}

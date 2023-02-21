//
//  ArchiveView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 13/2/2023.
//

import SwiftUI

struct ArchiveView: View {
    //MARK: - PROPERTIES
    @StateObject var archiveViewModel = ArchiveViewModel()
    @Namespace var animation
    
    
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            VStack{
                header
                    .padding(.bottom, 8)
                
                VStack{
                    HStack{
                        month
                            .padding(.leading, 4)
                        
                        Spacer()
                    }
                    
                    
                    //CALENDAR
                    weeklyCalendar
                        .padding(.bottom, 20)
                }
                
                
                //TOTAL CAFFEINE
                totalCaffeine
                    .padding(.bottom, 20)
                
                VStack{
                    //TIME LINE HEADER
                    timeLineHeader
                        .padding(.bottom, 10)
                    
                    Divider()
                        .padding(.bottom, 10)
                    
                    //TIME LINE
                    ScrollView(.vertical, showsIndicators: false) {
                        archiveListView
                    }
                    
                }
            }
            .padding(.horizontal, 32)
        }
    }
    //MARK: - COMPONENTS
    
    //HEADER
    fileprivate var header : some View {
        HStack(alignment: .center) {
            Text("Archive")
                .font(.system(size: 32))
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    fileprivate var month : some View {
        Text(archiveViewModel.fetchCurrentMonth())
            .font(.system(size: 18))
            .foregroundColor(.gray)
            .padding(.trailing, 30)
        
    }
    
    //TOTAL CAFFEINE
    fileprivate var totalCaffeine : some View {
        HStack(alignment: .center){
            Text("Total Caffeine")
                .font(.system(size: 24).bold())
            
            Spacer()
            
            HStack{
                Text("40")
                    .foregroundColor(Color("mainColor"))
                
                Text("/ 400mg")
            }
            .font(.system(size: 16))
            .padding(12)
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 1))
            
        }
    }
    
    
    //WEEKLY CALENDAR
    fileprivate var weeklyCalendar : some View {
        VStack {
            HStack(spacing: 10) {
                
                ForEach(archiveViewModel.currentWeek, id: \.self) { day in
                    VStack(spacing: 10) {
                        Text(archiveViewModel.formatDate(day: day))
                        Text(archiveViewModel.formatDay(date: day))
                        
                        Image("coffeeBean")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        //                        Circle()
                        //                            .fill(.white)
                        //                            .frame(width: 8, height: 8)
                        //                            .opacity(archiveViewModel.isToday(date: day) ? 1 : 0)
                    }//: VSTACK
                    .foregroundColor(archiveViewModel.isToday(date: day) ? .white : .black.opacity(0.5))
                    .font(.system(size: 14))
                    .frame(maxWidth: .infinity, maxHeight: 90)
                    .background(
                        ZStack{
                            if archiveViewModel.isToday(date: day) {
                                Capsule()
                                    .fill(Color("mainColor"))
                                    .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                            }
                        } //: ZSTACK
                    )
                    .contentShape(Capsule())
                    .onTapGesture {
                        //Updating Current Day
                        withAnimation {
                            archiveViewModel.currentDay = day
                            archiveViewModel.fetchSelectedBeverages(for: day)
                        }
                    }
                } //: FOREACH
            }
        }
    }
    
    //TIME LINE HEADER
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
    
    //ARCHIVE LIST VIEW
    fileprivate var archiveListView: some View {
        ForEach(archiveViewModel.selectedBeverages, id: \.id) { beverage in
            NavigationLink(destination: ArchiveListDetailView(
                viewModel: archiveViewModel, day: beverage.registerDate,
                date: beverage.registerDate,
                time: beverage.registerDate,
                month: beverage.registerDate, detailImage: beverage.imageName,
                detailName: beverage.name)) {
                    ArchiveListView(
                        title: beverage.name,
                        size: beverage.size,
                        numberOfShots: beverage.numberOfShots,
                        date: beverage.registerDate)
                }
        }
        .onAppear {
            archiveViewModel.fetchSelectedBeverages(for: archiveViewModel.currentDay)
        }
    }
    
}

//MARK: - EXTENSION
extension Date {
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

//MARK: - PREVIEW
struct ArchiveView_Previews: PreviewProvider {
    static var previews: some View {
        ArchiveView()
    }
}

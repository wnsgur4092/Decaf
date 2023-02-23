//
//  ArchiveView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 13/2/2023.
//

import SwiftUI

struct ArchiveView: View {
    //MARK: - PROPERTIES
    @StateObject var archiveViewModel : ArchiveViewModel
    @Namespace var animation
    
    @State private var isDetailViewPresented = false
    
    @State private var currentDay = Date()
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            ScrollView{
                header
                    .padding(.vertical,12)
                    .padding(.horizontal, 32)
                
                Divider()
                    .padding(.bottom, 10)
                
                VStack{
                    HStack{
                        month
                            .padding(.leading, 4)
                            .padding(.horizontal, 32)
                        
                        Spacer()
                    }
                    
                    
                    //CALENDAR
                    weeklyCalendar
                        .padding(.vertical, 10)
                        .padding(.horizontal, 32)
                    
                }
                
                
                //TOTAL CAFFEINE
                totalCaffeine
                    .padding(.bottom, 20)
                    .padding(.horizontal, 32)
                
                VStack{
                    //TIME LINE HEADER
                    timeLineHeader
                        .padding(.bottom, 10)
                    
                    Divider()
                        .padding(.bottom, 10)
                    
                    //TIME LINE
                    
                    archiveListView
                    
                }
                .padding(.horizontal, 32)
            }
        }
        .onChange(of: archiveViewModel.currentDay) { day in
            archiveViewModel.fetchSelectedBeverages(for: day)
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
                
                Text(String(format: "%.1f", archiveViewModel.totalCaffeineForToday()))
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
                    }//: VSTACK
                    .padding(.vertical, 12)
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
                            //                            archiveViewModel.fetchSelectedBeverages(for: day)
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
            VStack(spacing: 10) {
                HStack(alignment: .top, spacing: 5) {
                    Text(archiveViewModel.formatTime(time: beverage.registerDate))
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                        .offset(y: 4)
                        .frame(maxWidth: 80,
                               alignment: .topLeading)
                    
                    HStack {
                        VStack{
                            Text(beverage.name)
                                .font(.system(size: 14).bold())
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity,
                                       alignment: .leading)
                                .padding(.bottom, 16)
                            
                            Text(beverage.size)
                                .font(.system(size: 12))
                                .fontWeight(.regular)
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity,
                                       alignment: .leading)
                                .padding(.bottom, 5)
                            
                            Text("\(String(format: "%.1f", beverage.numberOfShots)) Shots")
                                .font(.system(size: 12))
                                .fontWeight(.regular)
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity,
                                       alignment: .leading)
                        }
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white)
                    }
                    .padding(15)
                    .frame(maxWidth: .infinity,
                           alignment: .leading)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color("mainColor")))
                    .onTapGesture {
                        isDetailViewPresented.toggle()
                    }
                    
                }
            }
            .fullScreenCover(isPresented: $isDetailViewPresented) {
                ArchiveListDetailView(viewModel: ArchiveViewModel(), beverage: beverage, day: beverage.registerDate, date: beverage.registerDate, time: beverage.registerDate, month: beverage.registerDate, detailImage: beverage.imageName, detailName: beverage.name, shots: Double(beverage.numberOfShots), size: beverage.size, caffeine: Double(beverage.caffeine))
                
            }
        }
        .onAppear{
            archiveViewModel.fetchSelectedBeverages(for: currentDay )
        }
    }
}

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
        VStack{
            header
            
            //CALENDAR
            weeklyCalendar
                .padding(.bottom, 20)

            //TOTAL CAFFEINE
            totalCaffeine
                .padding(.bottom, 40)
            //TIME LINE
            ScrollView(.vertical, showsIndicators: true) {
                Text("fewfwefewf")
                Text("fewfwefewf")
                Text("fewfwefewf")
                Text("fewfwefewf")
                Text("fewfwefewf")
                
            }
        }
        .padding(.horizontal, 32)
        
        
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
                        }
                    }
                } //: FOREACH
            }
        }
    }
    
    fileprivate var archiveListView : some View {
        LazyVStack{
            
        }
    }
}

struct ArchiveView_Previews: PreviewProvider {
    static var previews: some View {
        ArchiveView()
    }
}

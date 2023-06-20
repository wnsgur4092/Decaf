////
////  ArchiveView.swift
////  Decaffeine
////
////  Created by JunHyuk Lim on 13/2/2023.
////
//
//import SwiftUI
//
//struct ArchiveView: View {
//    //MARK: - PROPERTIES
//    @EnvironmentObject var sharedDataViewModel : ShareDataViewModel
//    @Namespace var animation
//    @Environment(\.presentationMode) var presentationMode
//    
//    //    @State private var selectedBeverage: SelectedBeverage
//    
//    @State private var isDetailViewPresented = false
//    @State private var currentDate = Date()
//    @State var currentMonth : Int = 0
//    let columns = Array(repeating: GridItem(.flexible()), count: 7)
//    
//    //MARK: - BODY
//    var body: some View {
//        NavigationView {
//            VStack{
//                header
//                    .padding(.vertical,12)
//                    .padding(.horizontal, 20)
//                
//                ScrollView{
//
//                    Divider()
//                        .padding(.bottom, 10)
//                                        
//                    
//                    //TOTAL CAFFEINE
////                    totalCaffeine
////                        .padding(.bottom, 20)
////                        .padding(.horizontal, 32)
//                    
//                    CustomCalendar(currentDate: $currentDate)
//                        .environmentObject(ShareDataViewModel())
//                    
//                    VStack{
//                        //TIME LINE HEADER
//                        timeLineHeader
//                            .padding(.bottom, 10)
//                        
//                        Divider()
//                            .padding(.bottom, 10)
//                        
//                        //TIME LINE
//                        
//                        archiveListView
//                        
//                    }
//                    .padding(.horizontal, 32)
//                   
//                }
//                .onChange(of: sharedDataViewModel.currentDay) { day in
//                    sharedDataViewModel.fetchSelectedBeverages(for: day)
//                }
//            }
//        
//        }
//        .navigationBarBackButtonHidden(true)
//
//    }
//    
//    //MARK: - COMPONENTS
//    
//    //HEADER
//    fileprivate var header : some View {
//        HStack(alignment: .center) {
//            Button {
//                presentationMode.wrappedValue.dismiss()
//            } label: {
//                Image(systemName: "chevron.left")
//                    .font(.system(size: 32))
//            }
//            
//            
//            Text("History")
//                .font(.system(size: 32))
//                .fontWeight(.bold)
//                .foregroundColor(.black)
//            
//            Spacer()
//        }
//        .frame(maxWidth: .infinity, alignment: .leading)
//    }
//    
//    fileprivate var month : some View {
//        Text(sharedDataViewModel.fetchCurrentMonth())
//            .font(.system(size: 18))
//            .foregroundColor(.gray)
//            .padding(.trailing, 30)
//        
//    }
//    
//    //TOTAL CAFFEINE
//    fileprivate var totalCaffeine : some View {
//        HStack(alignment: .center){
//            Text("Total Caffeine")
//                .font(.system(size: 24).bold())
//            
//            Spacer()
//            
//            HStack{
//                
//                Text(String(format: "%.1f", sharedDataViewModel.totalCaffeineForToday.wrappedValue))
//                    .foregroundColor(sharedDataViewModel.totalCaffeineForToday.wrappedValue > 400 ? Color.red : Color("mainColor"))
//                
//                Text("/ 400mg")
//            }
//            .font(.system(size: 16))
//            .padding(12)
//            .overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 1))
//            
//        }
//    }
//    
//
//    
//    //TIME LINE HEADER
//    fileprivate var timeLineHeader : some View {
//        HStack {
//            Text("Time")
//                .font(.subheadline)
//                .multilineTextAlignment(.leading)
//                .opacity(0.4)
//                .frame(alignment: .leading)
//                .padding(.trailing, 50)
//            
//            Text("Beverage")
//                .font(.subheadline)
//                .multilineTextAlignment(.leading)
//                .opacity(0.4)
//                .frame(maxWidth: .infinity,
//                       alignment: .leading)
//        }
//    }
//    
//    //ARCHIVE LIST VIEW
//    fileprivate var archiveListView: some View {
//        ForEach(sharedDataViewModel.selectedBeverages, id: \.id) { beverage in
//            VStack(spacing: 10) {
//                HStack(alignment: .top, spacing: 5) {
//                    Text(sharedDataViewModel.formatTime(time: beverage.registerDate))
//                        .font(.subheadline)
//                        .multilineTextAlignment(.leading)
//                        .offset(y: 4)
//                        .frame(maxWidth: 80, alignment: .topLeading)
//                    HStack {
//                        VStack{
//                            Text(beverage.name)
//                                .font(.system(size: 14).bold())
//                                .foregroundColor(Color.white)
//                                .multilineTextAlignment(.leading)
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                                .padding(.bottom, 16)
//                            Text(beverage.size)
//                                .font(.system(size: 12))
//                                .fontWeight(.regular)
//                                .foregroundColor(Color.white)
//                                .multilineTextAlignment(.leading)
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                                .padding(.bottom, 5)
//                            Text("\(String(format: "%.1f", beverage.numberOfShots)) Shots")
//                                .font(.system(size: 12))
//                                .fontWeight(.regular)
//                                .foregroundColor(Color.white)
//                                .multilineTextAlignment(.leading)
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                        }
//                        Spacer()
//                        Image(systemName: "chevron.right")
//                            .foregroundColor(.white)
//                    }
//                    .padding(15)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .background(RoundedRectangle(cornerRadius: 20).fill(Color("mainColor")))
//                    .onTapGesture {
//                        isDetailViewPresented.toggle()
//                        
//                        print("TroubleShooting \(beverage.name)")
//                    }
//                }
//            }
//        }
//    }
//}
//
//

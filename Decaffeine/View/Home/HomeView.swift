//
//  HomeView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 29/1/2023.
//

import SwiftUI

struct HomeView: View {
    //MARK: - PROPERTIES
    @State var hasTapped : Bool = false
    @EnvironmentObject var sharedDataViewModel : ShareDataViewModel
    
    @State private var isPresented = false
    @State private var isArchiveViewShowing = false
    
    @State var currentDate : Date = Date()
    
    @State private var isActive = false
    
    let maximumCaffeinePerDay : Double = 400
    let calendar = Calendar.current
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()
    
    
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            VStack{
                ScrollView(.vertical, showsIndicators: true) {
                    VStack{
                        header
                            .padding(.vertical,12)
                            .padding(.horizontal, 32)
                        
                        Spacer()
                            .frame(maxHeight: 32)
                        
                        coffeeListImage
                        
                        VStack{
                            coffeeCountText
                                .padding(.bottom, 10)
                            
                            coffeeProgressBar
                        }
                        .padding(.horizontal, 32)
                        
                        addNewButton
                            .padding(.vertical, 20)
                            .padding(.horizontal, 32)
                    }
                    
                }
            }
        }
        .fullScreenCover(isPresented: $isPresented) {
            BeverageSelectView(isPresented: $isPresented)
        }
        
    }
    
    //MARK: - COMPONENTS
    
    //HEADER
    fileprivate var header : some View {
        HStack(alignment: .center) {
            Text("Today,")
                .font(.system(size: 32))
                .fontWeight(.bold)
            
            Text(dateFormatter.string(from: Date()))
                .font(.system(size: 32))
                .fontWeight(.light)
            
            Spacer()
            
            NavigationLink(destination: CustomCalendar(currentDate: $currentDate), isActive: $sharedDataViewModel.isArchiveViewShowing) {
                ZStack {
                    Image(systemName: "calendar.circle")
                        .font(.system(size: 32))
                    
                    // Red dot on the bottom right
                    if sharedDataViewModel.hasNewData {
                        Circle()
                            .foregroundColor(.red)
                            .frame(width: 10, height: 10)
                            .offset(x: 12, y: 12)
                    }
                }
            }
            .environmentObject(self.sharedDataViewModel) // Pass the existing environment object
            .onAppear {
                sharedDataViewModel.hasNewData = false // Reset the new data flag
            }
        }
        .foregroundColor(.black)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    fileprivate var coffeeListImage : some View {
        VStack{
            if sharedDataViewModel.selectedBeverages.filter({ calendar.isDate($0.registerDate, inSameDayAs: Date()) }).isEmpty {
                noList
                    .frame(height: 400)
                    .padding(.vertical, 10)
            } else {
                TabView{
                    ForEach(sharedDataViewModel.selectedBeverages) { item in
                        BeverageCardView(beverageName: item.name, beverageImageName: item.imageName)
                    }
                }
                .frame(height: 400)
                .tabViewStyle(PageTabViewStyle())
            }
        }
    }
    
    
    //COFFEE LIST DETAIL
    fileprivate var noList : some View {
        VStack(spacing: 8){
            Image("noList")
            
            Text(sharedDataViewModel.numberOfBeveragesForToday() == 0 ? "You haven't had any coffee yet" : "You have no coffee history for this day")
                .font(.system(size: 18))
                .fontWeight(.bold)
                .foregroundColor(Color("mainColor"))
            
            //Coffee Shot & Caffeine Content
            Text(sharedDataViewModel.numberOfBeveragesForToday() == 0 ? "Create your caffeine history" : "Add your first coffee for the day")
                .font(.system(size: 14))
                .fontWeight(.regular)
                .foregroundColor(Color("mainColor").opacity(0.6))
        }
    }
    
    
    //COFFEE COUNT TEXT
    fileprivate var coffeeCountText : some View {
        HStack{
            Text("You've had \(sharedDataViewModel.numberOfBeveragesForToday()) coffees")
                .font(.system(size: 16))
                .fontWeight(.regular)
                .foregroundColor(Color("mainColor").opacity(0.8))
            
            Spacer()
        }
    }
    
    //PROGRESS BAR
    fileprivate var coffeeProgressBar : some View {
        VStack{
            HStack{
                Text("Today's Caffeine")
                
                Spacer()
                
                HStack{
                    Text("\(String(format: "%.1f", sharedDataViewModel.totalCaffeineForToday()))")
                        .foregroundColor(sharedDataViewModel.totalCaffeineForToday() < maximumCaffeinePerDay ? Color("mainColor") : Color.red)
                    Text("/ \(String(format: "%.1f", maximumCaffeinePerDay))mg")
                    
                }
                
            }
            
            ProgressBar(todayIntake: Double(sharedDataViewModel.totalCaffeineForToday()) , totalIntake: Double(maximumCaffeinePerDay))
        }
    }
    
    //BUTTON
    fileprivate var addNewButton : some View {
        Button {
            isPresented = true
        } label: {
            Text("+ Add New Caffeine")
        }
        .buttonStyle(ActiveButtonStyle())
    }
}


//MARK: - PREVIEW
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ShareDataViewModel())
    }
}

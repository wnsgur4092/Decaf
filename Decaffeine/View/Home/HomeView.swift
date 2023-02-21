//
//  HomeView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 29/1/2023.
//

import SwiftUI

struct HomeView: View {
    //MARK: - PROPERTIES
    @StateObject var homeVM : HomeViewModel
    @EnvironmentObject var archiveViewModel: ArchiveViewModel
    
    @State var isPresenting = false
    
    let maximumCaffeinePerDay : Int = 400
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        return formatter
    }()
    
    //MARK: - BODY
    var body: some View {
        VStack {
            VStack{
                header
                    .padding(.vertical,12)
                
                CarouselView()
                
            }
            .padding(.horizontal, 32)
            
            VStack {
                VStack{
                    coffeeListDetail
                        .padding(.top, 40)
                        .padding(.bottom, 60)
                    
                    coffeeCountText
                        .padding(.bottom, 10)
                    
                    coffeeProgressBar
                    
                    Spacer()
                    
                    addNewButton
                        .frame(alignment:.bottom)
                        .padding(.bottom, 60)
                }
                .padding(.horizontal, 32)
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .frame(maxWidth: .infinity)
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
            
            Image("noList")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 42, maxHeight: 42)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 0.5))
        }
        .foregroundColor(.black)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    //COFFEE LIST IMAGE
    fileprivate var coffeeListImage : some View {
        //IF NO DATA IN COFFEE LIST
//        VStack{
//            //Image
//            Image("noList")
        HStack {
            ForEach(homeVM.list) { list in
                BeverageListCell(beverageName: list.name, beverageImageName: list.imageName)
            }
        }
            
//        } //: VSTACK : THERE IS NO DATA
    }
    
    //COFFEE LIST DETAIL
    fileprivate var coffeeListDetail : some View {
        VStack(spacing: 8){
            Text("You did not drink coffee yet")
                .font(.system(size: 18))
                .fontWeight(.bold)
                .foregroundColor(Color("mainColor"))
            
            //Coffee Shot & Caffeine Content
            Text("Create the Caffeine History")
                .font(.system(size: 14))
                .fontWeight(.regular)
                .foregroundColor(Color("mainColor").opacity(0.6))
        }
    }
    
    //COFFEE COUNT TEXT
    fileprivate var coffeeCountText : some View {
        HStack{
            Text("You had total \(homeVM.numberOfBeveragesForToday()) coffees")
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
                    Text("\(homeVM.totalCaffeineForToday())")
                        .foregroundColor(homeVM.totalCaffeineForToday() <  maximumCaffeinePerDay ? Color("mainColor") : Color.red)
                    Text("/ \(maximumCaffeinePerDay)mg")
                }
 
            }
            
            ProgressBar(todayIntake: Double(homeVM.totalCaffeineForToday()) , totalIntake: Double(maximumCaffeinePerDay))
        }
    }
    
    //BUTTON
    fileprivate var addNewButton : some View {
        Button {
            print("---> next button tapped")
            isPresenting = true
        } label: {
            Text("+ Add New Caffeine")
        }
        .buttonStyle(ActiveButtonStyle())
        .sheet(isPresented: $isPresenting) {
            let vm = BeverageInputViewModel(isPresented: $isPresenting, selectedBeverages: $homeVM.list)
            
            BeverageSelectView(viewModel: vm)
        }
//        .sheet(isPresented: $isAddNewCaffeinePresenting) {
//            let vm = BeverageAddViewModel(isPresented: $isAddNewCaffeinePresenting, beverages: $homeVM.coffees)
//
////            BeverageSelectView(beverageAddvm: vm)
//        }
    }
}






struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(homeVM: HomeViewModel())
    }
}

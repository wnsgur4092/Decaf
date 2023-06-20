//
//  BeverageDetailView.swift
//  Decaffeine
//
//  Created by Jordan Pazdjara on 13/2/2023.
//

import SwiftUI

struct ArchiveListDetailView: View {
    
    //MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var sharedDataViewModel : ShareDataViewModel
    @State private var showingAlert = false
    
    var beverage : SelectedBeverage
    @StateObject var viewModel : ArchiveViewModel
    
    //MARK: - BODY
    var body: some View {
        VStack{
            ScrollView{
                header
                    .padding(.top, 12)
                    .padding(.horizontal, 20)
                
                Divider()
                    .padding(.bottom, 12)
                
                VStack {
                    
                    thumbnail
                    
                    Divider()
                        .padding(.bottom, 12)
                    
                    coffeeDescription
                        .padding(.horizontal, 32)
                        .padding(.bottom, 60)
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationBarBackButtonHidden(true)
    }

    
    //MARK: - COMPONENTS
    fileprivate var header : some View {
        VStack{
            HStack(alignment: .center, spacing: 16) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.down")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color("mainColor"))
                        .frame(width: 20,height: 20)
                }
                
                Text(viewModel.formatDate(day: beverage.registerDate)) //DAY
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                
                Text(viewModel.formatDay(date: beverage.registerDate)) //DATE
                    .font(.system(size: 24))
                
                Text(viewModel.formatMonth(month: beverage.registerDate)) //Month
                    .font(.system(size: 24))
                
                Spacer()
                
            }
            HStack{
                Spacer().frame(width:36, height: 20)
                
                Text (viewModel.formatTime(time:beverage.registerDate)) //Time
                    .font(.system(size: 20))
                
                Spacer()
            }
        }
    }
    
    fileprivate var thumbnail : some View {
        VStack {
            Image(beverage.imageName) // 수정
            
                .padding(.top, 40)
                .padding(.bottom, 20)
            
            Text(beverage.name) // 수정
                .font(.system(size: 30))
                .fontWeight(.bold)
                .padding(.bottom, 24)
        }
    }
    
    //Coffee Description Section
    fileprivate var coffeeDescription : some View {
        VStack {
            
            HStack(alignment: .bottom, spacing: 32){
                BeverageDetailCell(detailImageName: "small", detailName: "Size", detailExtra: beverage.size) // 수정
                BeverageDetailCell(detailImageName: "shot", detailName: "Shots", detailExtra: "\(beverage.numberOfShots)") // 수정
                BeverageDetailCell(detailImageName: "coffeeBean", detailName: "Caffeine", detailExtra: "\(beverage.caffeine)mg" ) // 수정
                
            }
        }
        .frame(maxWidth: .infinity)
    }
}


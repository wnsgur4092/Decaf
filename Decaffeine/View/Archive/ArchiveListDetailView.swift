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
    @State private var showingAlert = false
    
    @StateObject var viewModel : ArchiveViewModel
    @State var selectedBeverage : SelectedBeverage
    
    
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

//            Spacer()
//            Divider()
//            HStack{
//                Spacer()
//
//                deleteButton
//            }
//            .padding(.horizontal, 20)
        }
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
    
    //MARK: - COMPONENTS
    fileprivate var header : some View {
        VStack{
            HStack(alignment: .center, spacing: 16) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color("mainColor"))
                        .frame(width: 20,height: 20)
                }
                
                Text(viewModel.formatDate(day: viewModel.selectedBeverage.registerDate)) //DAY
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                
                Text(viewModel.formatDay(date: viewModel.selectedBeverage.registerDate)) //DATE
                    .font(.system(size: 24))
                
                Text(viewModel.formatMonth(month: viewModel.selectedBeverage.registerDate)) //Month
                    .font(.system(size: 24))
                
                Spacer()
                
            }
            HStack{
                Spacer().frame(width:36, height: 20)
                
                Text (viewModel.formatTime(time: viewModel.selectedBeverage.registerDate)) //Time
                    .font(.system(size: 20))
                
                Spacer()
            }
        }
    }
    
    fileprivate var thumbnail : some View {
        VStack {
            Image(selectedBeverage.imageName) // 수정
            
                .padding(.top, 40)
                .padding(.bottom, 20)
            
            Text(selectedBeverage.name) // 수정
                .font(.system(size: 30))
                .fontWeight(.bold)
                .padding(.bottom, 24)
        }
    }
    
    //Coffee Description Section
    fileprivate var coffeeDescription : some View {
        VStack {
            
            HStack(alignment: .bottom, spacing: 32){
                BeverageDetailCell(detailImageName: "small", detailName: "Size", detailExtra: selectedBeverage.size) // 수정
                BeverageDetailCell(detailImageName: "shot", detailName: "Shots", detailExtra: "\(selectedBeverage.numberOfShots)") // 수정
                BeverageDetailCell(detailImageName: "coffeeBean", detailName: "Caffeine", detailExtra: "\(selectedBeverage.caffeine)mg" ) // 수정
                
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    fileprivate var deleteButton : some View {
        HStack {
            Spacer()
            Button {
                showingAlert = true
            } label: {
                Image(systemName: "trash")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.red)
                    .frame(maxWidth: 20, maxHeight: 25)
                    .padding(32)
            }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Are you sure you want to delete this coffee?"),
                    primaryButton: .destructive(
                        Text("Delete"),
                        action: {
//                            viewModel.deleteData(selectedBeverage: beverage)
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    ),
                    secondaryButton: .cancel()
                )
            }
        }
        .accentColor(Color("mainColor"))
    }
}


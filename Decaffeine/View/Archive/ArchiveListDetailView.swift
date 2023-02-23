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
    
    @ObservedObject var viewModel : ArchiveViewModel
    var beverage: SelectedBeverage
    
    var day: Date
    var date : Date
    var time : Date
    var month : Date
    var detailImage : String
    var detailName : String
    
    //MARK: - BODY
    var body: some View {
        ScrollView{
            header
                .padding(.top, 12)
                .padding(.horizontal, 20)
            
            Divider()
                .padding(.bottom, 12)
            
            VStack {
                
                thumbnail
                
                Divider()
                
                coffeeDescription
                    .padding(.horizontal, 32)
                    .padding(.bottom, 28)
                
                deleteButton

            }
            
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
                
                Text(viewModel.formatDate(day: day)) //DAY
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                
                Text(viewModel.formatDay(date: date)) //DATE
                    .font(.system(size: 24))
                
                Text(viewModel.formatMonth(month: date)) //DATE
                    .font(.system(size: 24))
                
                Spacer()
                
            }
            HStack{
                Spacer().frame(width:36, height: 20)
                
                Text (viewModel.formatTime(time: date)) //Time
                    .font(.system(size: 20))
                
                Spacer()
            }
        }
    }
    
    fileprivate var thumbnail : some View {
        VStack {
            Image(detailImage)
                .padding(.top, 40)
                .padding(.bottom, 20)
            
            Text(detailName)
                .font(.system(size: 30))
                .fontWeight(.bold)
                .padding(.bottom, 24)
        }
    }
    
    //Coffee Description Section
    fileprivate var coffeeDescription : some View {
        VStack {
            
            
            HStack(alignment: .bottom, spacing: 32){
                BeverageDetailCell(detailImageName: "small", detailName: "Size", detailExtra: "Small")
                BeverageDetailCell(detailImageName: "shot", detailName: "Shots", detailExtra: "4")
                BeverageDetailCell(detailImageName: "coffeeBean", detailName: "Caffeine", detailExtra: "126mg")
                
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
                    .frame(maxWidth: 20, maxHeight: 25)
                    .padding(32)
            }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Are you sure you want to delete this coffee?"),
                    primaryButton: .destructive(
                        Text("Delete"),
                        action: {
//                            viewModel.deleteBeverage(day: beverage.registerDate, name: beverage.name)
                            // Dismiss view after deleting
                            presentationMode.wrappedValue.dismiss()
                        }
                    ),
                    secondaryButton: .cancel()
                )
            }

            
            .padding(.trailing, 16)
        }
        .accentColor(Color("mainColor"))
    }
}


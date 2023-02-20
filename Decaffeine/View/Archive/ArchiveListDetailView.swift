//
//  BeverageDetailView.swift
//  Decaffeine
//
//  Created by Jordan Pazdjara on 13/2/2023.
//

import SwiftUI

struct ArchiveListDetailView: View {
    
    //MARK: - PROPERTIES
    @State private var showingAlert = false

    @ObservedObject var viewModel : ArchiveViewModel
    
    var day: Date
    var date : Date
    var time : Date
    var month : Date
    var detailImage : String
    var detailName : String
    
    //MARK: - BODY
    var body: some View {
        VStack {
            
            Spacer()
                .frame(maxHeight: 64)
            
            header
            
            Spacer()
                .frame(maxHeight: 150)
            
            
            image
            
            Spacer()
                .frame(maxHeight: 150)
            
            VStack {
                
                coffeeDescription
                
                Spacer()
                
                deleteButton
            }
            .background(
                Color.white
                    .clipShape(CustomCorner(corners: [.topLeft,.topRight], radius: 33))
                    .ignoresSafeArea()
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("mainColor"))
        .edgesIgnoringSafeArea(.top)
    }
    
    //MARK: - COMPONENTS
    fileprivate var header : some View {
        HStack(alignment: .center) {
            Button {
                //show previous view
            } label: {
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 20,maxHeight: 20)
            }
            .padding(.leading, 24)
            .padding(.trailing, 24)
            
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(viewModel.formatDate(day: day)) //DAY
                        .fontWeight(.bold)
                        .font(.system(size: 24))
                    
                    Text(viewModel.formatDay(date: date)) //DATE
                        .font(.system(size: 24))
                    
                    Text(viewModel.formatMonth(month: date)) //DATE
                        .font(.system(size: 24))
                    
                } //Date recorded on app
                Text (viewModel.formatTime(time: date)) //Time
                    .font(.system(size: 20))
                
            }
            .foregroundColor(.white)
            
            
            Spacer()
        }
        .accentColor(Color(.white))
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    fileprivate var image : some View {
        Image(detailImage)
    }
    
    //Coffee Description Section
    
    fileprivate var coffeeDescription : some View {
        VStack {
            Text(detailName)
                .font(.system(size: 30))
                .fontWeight(.bold)
                .padding(.top, 48)
                .padding(.bottom, 24)
            
            HStack{
                BeverageDetailCell(detailImageName: "small", detailName: "Size", detailExtra: "Large")
                BeverageDetailCell(detailImageName: "shot", detailName: "Shots", detailExtra: "4")
                BeverageDetailCell(detailImageName: "coffeebean", detailName: "Shots", detailExtra: "126mg")
                
            }
        }
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
                    primaryButton: .destructive(Text("Delete")) {
                        print("Deleting...") //put here code to delete coffee
                    },
                    secondaryButton: .cancel()
                )
            }
            
            .padding(.trailing, 16)
        }
        .accentColor(Color("mainColor"))
    }
}

//struct ArchiveListDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArchiveListDetailView(viewModel: ArchiveViewModel(), day: <#T##Date#>, date: <#T##Date#>, time: <#T##Date#>, beverageImage: <#T##String#>, month: <#T##Date#>)
//    }
//}

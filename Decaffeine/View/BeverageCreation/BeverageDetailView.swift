//
//  BeverageDetailView.swift
//  Decaffeine
//
//  Created by Jordan Pazdjara on 13/2/2023.
//

import SwiftUI

struct BeverageDetailView: View {
    
    @State private var showingAlert = false
    
    //grid to make items level
    
    let layout : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            
            Spacer()
                .frame(maxHeight: 64)
            
            header
            
            Spacer()
                .frame(maxHeight: 150)
            
            //Image(coffetype.image)
            Text("Coffee Image") // image goes here of selected coffee
            
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
    
    //HEADER
    
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
            .padding(.trailing, 16)
            
            Group {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Thu,")
                            .fontWeight(.bold)
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                        Text("05 Jun")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                    } //Date recorded on app
                    Text ("11:35 AM") //Time recorded on app
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                }
            }
            
            Spacer()
        }
        .accentColor(Color(.white))
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    //Coffee Description Section
    
    fileprivate var coffeeDescription : some View {
        VStack {
            Spacer()
                .frame(maxHeight: 48)
            Text("Coffee Title")
                .font(.system(size: 30))
                .fontWeight(.bold)
                .padding(.bottom, 24)
            LazyVGrid(columns: layout) {
                
                BeverageDetailCell(detailImageName: "coffeedetailsize", detailName: "Size", detailExtra: "Large")
                BeverageDetailCell(detailImageName: "coffeedetailshot", detailName: "Shots", detailExtra: "4")
                
                VStack {
                    
                    Text("Caffeine")
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .padding(.bottom, 36)
                    Text("2000mg")
                        .padding(.bottom, 16)
                }
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

struct BeverageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BeverageDetailView()
    }
}

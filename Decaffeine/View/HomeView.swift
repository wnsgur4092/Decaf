//
//  HomeView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 29/1/2023.
//

import SwiftUI

struct HomeView: View {
    //MARK: - PROPERTIES
    @StateObject var vm = ProfileViewModel()
    
    //MARK: - BODY
    var body: some View {
        VStack{
            //HEADER + PROFILE IMAGE
            VStack {
                header
                    .padding(.top, 52)
                    .padding(.bottom, 40)
                    .padding(.horizontal,32)
                
                coffeeListImage
                
            }
            
            VStack {
                VStack{
                    
                    coffeeListDetail
                        .padding(.top, 20)
                        .padding(.bottom, 48)
                    
                    coffeeCountText
                        .padding(.bottom, 10)
                    
                    coffeeProgressBar
            
                    
                    addNewButton
                        .frame(alignment:.bottom)
                        .padding(.top, 12)
                }
            }
            .padding(.horizontal,32)
            .padding(.bottom, 60)
            .background(
                Color.white
                    .frame(maxWidth:.infinity, maxHeight: .infinity)
                    .clipShape(CustomCorner(corners: [.topLeft,.topRight], radius: 33))
                    .ignoresSafeArea()
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("mainColor"))
        .edgesIgnoringSafeArea(.all)
    }
    
    //MARK: - COMPONENTS
    
    //HEADER
    fileprivate var header : some View {
        HStack(alignment: .center) {
            Text("Today,")
                .font(.system(size: 32))
                .fontWeight(.bold)
            
            Text("10 Jun")
                .font(.system(size: 32))
                .fontWeight(.light)
            
            Spacer()
            
            vm.image!
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 42, maxHeight: 42)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 0.5))
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    //COFFEE LIST IMAGE
    fileprivate var coffeeListImage : some View {
        //IF NO DATA IN COFFEE LIST
        VStack{
            //Image
            Image("noList")
            
        } //: VSTACK : THERE IS NO DATA
    }
    
    //COFFEE LIST DETAIL
    fileprivate var coffeeListDetail : some View {
        VStack(spacing: 8){
            Text("No Caffeine Record Yet")
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
            Text("You durnk total 0 coffees")
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
                    Text("0")
                        .foregroundColor(Color("mainColor"))
                    Text("/ 400mg")
                }
            }
            
            ProgressBar(todayIntake: 20, totalIntake: 400)
        }
    }
    
    
    
    //BUTTON
    fileprivate var addNewButton : some View {
        Button {
            print("next button tapped")
        } label: {
            Text("+ Add New Caffeine")
        }
        .buttonStyle(ActiveButtonStyle())
        
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

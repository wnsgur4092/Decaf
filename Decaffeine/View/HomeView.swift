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
    
    @State var isAddNewCaffeine = false
    
    //MARK: - BODY
    var body: some View {
        VStack {
            VStack{
                header
                coffeeListImage
            }
            .padding(.horizontal, 20)
            
            VStack {
                VStack{
                    
                    coffeeListDetail
                        .padding(.top, 20)
                        .padding(.bottom, 60)
                    
                    coffeeCountText
                        .padding(.bottom, 10)
                    
                    coffeeProgressBar
                    
                    Spacer()
                    
                    addNewButton
                        .frame(alignment:.bottom)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 32)
                }
                .padding(.horizontal, 20)
            }
            .background(
                Color.white
                    .frame(maxWidth:.infinity, maxHeight: .infinity)
                    .clipShape(CustomCorner(corners: [.topLeft,.topRight], radius: 33))
                    .ignoresSafeArea()
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("mainColor").ignoresSafeArea(edges: [.top, .bottom]))
        .frame(maxWidth: .infinity)
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
            
            ProgressBar(todayIntake: 0, totalIntake: 400)
        }
    }
    
    //BUTTON
    fileprivate var addNewButton : some View {
        Button {
            print("---> next button tapped")
            isAddNewCaffeine = true
        } label: {
            Text("+ Add New Caffeine")
        }
        .buttonStyle(ActiveButtonStyle())
        .sheet(isPresented: $isAddNewCaffeine) {
            BeverageListView()
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

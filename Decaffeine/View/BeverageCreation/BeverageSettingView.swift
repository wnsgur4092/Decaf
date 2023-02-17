//
//  BeverageSettingView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 18/2/2023.
//

import SwiftUI

struct BeverageSettingView: View {
    //MARK: - COMPONENTS
    @Environment(\.presentationMode) var presentationMode
    
    let cupSizes = [("Small", "Tall"), ("Regular", "Grande"), ("Large", "Venti")]
    
    @ObservedObject var vm : BeverageAddViewModel

    
    //MARK: - BODY
    var body: some View {
        VStack{
            ScrollView(.vertical, showsIndicators: false) {
                topHeader
                    .padding(.bottom, 20)
                
                VStack{
                    sizeSelection
                        .padding(.bottom, 20)
                    
                    numberOfShotsButton
                        .padding(.horizontal, 60)
                        .padding(.bottom, 60)
                    
                    buttonSection
                        .padding(.horizontal, 32)
                        .padding(.bottom, 40)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("Add New Caffeine")

    }
    
    //MARK: - COMPONENTS
    fileprivate var topHeader : some View {
        VStack {
            Image(vm.coffeeImageName)
                .padding(.top, 40)
                .padding(.bottom, 40)
            
            Text(vm.coffeeName)
                .font(.system(size: 30).bold())
        }

        
    }
    
    fileprivate var sizeSelection : some View {
        VStack{
            Text("Select Size")
                .font(.system(size: 16).bold())
                .padding(.bottom, 16)
            
            HStack(alignment: .bottom, spacing: 10) {
                ForEach(cupSizes, id: \.0) { size, cupName in
                    VStack{
                        ZStack(alignment: .bottom) {
                            Rectangle()
                                .fill(Color.red)
                                .frame(width: 80, height: 110)
                                .cornerRadius(10)
                                
                            Image(size.lowercased())
                                .padding(.vertical, 8)
                            }
  
                        Text(size)
                            .font(.system(size: 14).bold())
                            .padding(.bottom, 2)
                        
                        Text(cupName)
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
    }
    
    fileprivate var numberOfShotsButton : some View {
        VStack(alignment: .center){
            
            Text("Number of Shots")
                .font(.system(size: 16).bold())
                .padding(.bottom, 16)
            
            HStack(alignment: .center){
                Button {
                    print("minusButton Tapped")
                } label: {
                    Image(systemName: "minus.circle")
                        .resizable()
                        .frame(width: 44, height: 44)
                }
                
                Spacer()
                
                Text("1")
                    .font(.system(size: 36).bold())

                Spacer()
                
                Button {
                    print("plusButton Tapped")
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 44, height: 44)
                }
            } //: BUTTON HSTACK
        }
    }
    
    
    fileprivate var buttonSection : some View {
        HStack{
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Back")
            }
            .frame(maxWidth: 80, maxHeight: 40)
            .buttonStyle(SecondaryButtonStyle())
            
            Spacer()
            
            Button {
                print("Save buttonTapped")
            } label: {
                Text("Save")
            }
            .frame(maxWidth: 80, maxHeight: 40)
            .buttonStyle(DisableButtonStyle())
            
            
        }
    }

    
}

//MARK: - PREVIEW
struct BeverageSettingView_Previews: PreviewProvider {
    static var previews: some View {
        BeverageSettingView(vm: BeverageAddViewModel(isPresented: .constant(false), beverages: .constant(Beverage.beverageList)))
    }
}

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
    var cupSizes = [("S", "Tall"), ("R", "Grande"), ("L", "Venti")]
    @State var selectedSize = "Small"
    @State private var selectedSizeIndex = 0
    @EnvironmentObject var sharedDataViewModel : ShareDataViewModel
    
    @State private var numberOfShots: Double = 0.5
    @State private var isSaveEnabled : Bool = false
    
    @State private var showingPopover = false
    
    @State var currentDay : Date = Date()
    
    @Binding var isPresented : Bool
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            VStack{
                ScrollView(.vertical, showsIndicators: true) {
                    beverageThumbnail
                        .padding(.bottom, 20)
                    
                    
                    Divider()
                        .padding(.bottom, 8)
                    
                    VStack{
                        sizeSelection
                            .padding(.bottom, 20)
                        
                        Divider()
                            .padding(.bottom, 8)
                        
                        numberOfShotsButton
                            .padding(.horizontal, 60)
                            .padding(.bottom, 60)
                    }
                }
                .padding(.horizontal, 20)
                
                
                VStack{
                    Divider()
                    buttonSection
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 20)
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
    //MARK: - COMPONENTS
    fileprivate var beverageThumbnail : some View {
        VStack {
            Image(sharedDataViewModel.selectedBeverage.imageName)
                .resizable()
                .scaledToFit()
                .frame(height:80)
                .padding(.top, 40)
                .padding(.bottom, 20)
            
            Text(sharedDataViewModel.selectedBeverage.name)
                .font(.system(size: 30).bold())
        }
    }
    
    
    fileprivate var sizeSelection: some View {
        VStack {
            Text("Select Size")
                .font(.system(size: 16).bold())
                .padding(.bottom, 16)
            
            HStack(alignment: .bottom, spacing: 10) {
                ForEach(Array(cupSizes.indices), id: \.self) { index in
                    VStack {
                        Button {
                            selectedSizeIndex = index
                            sharedDataViewModel.updateBeverageSize(size: cupSizes[index].0)
                        } label: {
                            ZStack(alignment: .bottom) {
                                Rectangle()
                                    .foregroundColor(selectedSizeIndex == index ? Color("mainColor") : Color.clear)
                                    .cornerRadius(10)
                                
                                Image("small")
                                    .padding()
                                
                                Text(cupSizes[index].0)
                                    .foregroundColor(.white)
                                    .padding(.vertical, 15)
                                    .padding(.horizontal, 40)
                                    .font(.system(size: 14).bold())
//                                    .scaleEffect(selectedSizeIndex == index ? 1.1 : 1.0)
//                                    .animation(.spring())
                            }
                        }
                        
                        Text(cupSizes[index].0)
                            .font(.system(size: 14).bold())
                            .padding(.bottom, 2)
                        
                        Text(cupSizes[index].1)
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
    }
    
    
    fileprivate var numberOfShotsButton: some View {
        VStack(alignment: .center) {
            Text("Number of Shots")
                .font(.system(size: 16).bold())
                .padding(.bottom, 16)
            HStack(alignment: .center) {
                Button {
                    withAnimation {
                        if numberOfShots > 0.5 {
                            numberOfShots -= 0.5
                            sharedDataViewModel.updateBeverageShots(numberOfShots: numberOfShots)
                            print("minusButton Tapped")
                            print("\(sharedDataViewModel.selectedBeverage.numberOfShots)")
                        }
                    }
                } label: {
                    Image(systemName: "minus.circle")
                        .resizable()
                        .frame(width: 44, height: 44)
                        .foregroundColor(numberOfShots > 0.5 ? Color("mainColor") : .gray)
                }
                Spacer()
                Text(String(numberOfShots))
                    .font(.system(size: 36).bold())
                
                Spacer()
                Button {
                    withAnimation {
                        numberOfShots += 0.5
                        sharedDataViewModel.updateBeverageShots(numberOfShots: numberOfShots)
                        print("plusButton Tapped")
                        print("\(sharedDataViewModel.selectedBeverage.numberOfShots)")
                    }
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 44, height: 44)
                        .foregroundColor(Color("mainColor"))
                }
            }
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
            
            Button(action: {
                sharedDataViewModel.saveData()
                sharedDataViewModel.fetchSelectedBeverages(for: currentDay)
                self.isPresented = false
            
            }) {
                Text("Save")
            }
            .frame(maxWidth: 80, maxHeight: 40)
            .buttonStyle(ActiveButtonStyle())
        }
    }
}

//MARK: - PREVIEW
struct BeverageSettingView_Previews: PreviewProvider {
    static var previews: some View {
        BeverageSettingView(isPresented: .constant(false))
            .environmentObject(ShareDataViewModel())
    }
}

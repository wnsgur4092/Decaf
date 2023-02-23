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
    
    @ObservedObject var viewModel : BeverageInputViewModel
    @State private var numberOfShots: Double = 0.5
    @State private var isSaveEnabled : Bool = false

    
    //MARK: - BODY
    var body: some View {
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
            .padding(.bottom, 28)
            .padding(.horizontal, 20)
            
    
            
            buttonSection
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 32)
                .padding(.bottom, 40)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("Add New Caffeine")
        
    }
    
    //MARK: - COMPONENTS
    fileprivate var beverageThumbnail : some View {
        VStack {
            Image(viewModel.selectedBeverage.imageName)
                .padding(.top, 40)
                .padding(.bottom, 20)
            
            Text(viewModel.selectedBeverage.name)
                .font(.system(size: 30).bold())
        }
        
        
    }
    
    fileprivate var sizeSelection: some View {
        VStack {
            Text("Select Size")
                .font(.system(size: 16).bold())
                .padding(.bottom, 16)

            HStack(alignment: .bottom, spacing: 10) {
                ForEach(cupSizes, id: \.0) { size, cupName in
                    VStack {
                        ZStack(alignment: .bottom) {
                            Rectangle()
                                .fill(viewModel.selectedSize == size ? Color("mainColor") : Color.clear)
                                .frame(width: 80, height: 110)
                                .cornerRadius(10)


                            Image(size.lowercased())
                                .padding(.vertical, 8)
                                .scaleEffect(viewModel.selectedSize == size ? 1.1 : 1.0)
                                .animation(.spring())
                        }

                        Text(size)
                            .font(.system(size: 14).bold())
                            .padding(.bottom, 2)

                        Text(cupName)
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal, 20)
                    .onTapGesture {
                        withAnimation {
                            viewModel.updateBeverageSize(size: size)
                            isSaveEnabled = true
                        }
                    }
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
                            viewModel.updateBeverageShots(numberOfShots: numberOfShots)
                            print("minusButton Tapped")
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
                        viewModel.updateBeverageShots(numberOfShots: numberOfShots)
                        print("plusButton Tapped")
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
            
            Button {
                print(viewModel.selectedBeverage.name)
                print(viewModel.selectedBeverage.imageName)
                print(viewModel.selectedBeverage.size)
                print(viewModel.selectedBeverage.numberOfShots)
                print(isSaveEnabled)
                
                viewModel.saveData()
                presentationMode.wrappedValue.dismiss()
                
            } label: {
                Text("Save")
            }
            .frame(maxWidth: 80, maxHeight: 40)
            .disabled(isSaveEnabled == false)
            .buttonStyle(CustomButtonStyle(
                isButtonEnabled: isSaveEnabled,
                activeStyle: activeStyle,
                disableStyle: disableStyle
            ))
            
            
        }
    }
    
    
}

//MARK: - PREVIEW
struct BeverageSettingView_Previews: PreviewProvider {
    static var previews: some View {
        BeverageSettingView(viewModel: BeverageInputViewModel(isPresented: .constant(false), selectedBeverages: .constant([])))
    }
}

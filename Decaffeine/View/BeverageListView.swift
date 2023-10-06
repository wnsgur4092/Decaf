//
//  BeverageListView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 2/10/2023.
//

import SwiftUI
import MijickPopupView

struct BeverageListView: View {
    @ObservedObject var viewModel = BeverageViewModel()
    @State private var showPhaseTwo: Bool = false
    @State private var selectedBeverage: Beverage?
    
    
    var body: some View {
        VStack {
            if showPhaseTwo {
                HStack{
                    Image(systemName: "arrow.left")
                        .resizable()
                        .scaledToFit()
                        .opacity(0.6)
                        .frame(width: 22, height: 22)
                        .onTapGesture {
                            // Navigate back to PhaseOne
                            withAnimation {
                                self.showPhaseTwo = false
                            }
                        }
                        .animation(.easeInOut(duration: 0.3))
                    
                    Spacer()
                }
                
            } else {
                Image(systemName: "chevron.left")
                    .resizable()
                    .frame(width: 22, height: 22)
                    .foregroundColor(.clear)
            }
            
            //Heading
            VStack(alignment: .leading) {
                HStack(alignment: .bottom){
                    Text("What did you drink\nToday?")
                        .font(.title)
                    
                    Spacer()
                    
                    Circle()
                        .frame(width: 10)
                    
                    Circle()
                        .frame(width: 10)
                        .foregroundColor(showPhaseTwo ? Color.black : Color.gray.opacity(0.3)) // Color changes based on whether PhaseTwo is active
                }
            }
            
            ZStack {
                if let beverage = selectedBeverage, showPhaseTwo {
                    PhaseTwo(selectedBeverage: beverage, showPhaseTwo: $showPhaseTwo)
                        .transition(.move(edge: .trailing)) // Add slide transition
                        .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0)) // Spring animation
                }
                
                if !showPhaseTwo {
                    PhaseOne(selectedBeverage: $selectedBeverage, showPhaseTwo: $showPhaseTwo)
                        .transition(.move(edge: .leading)) // Add slide transition
//                        .animation(.spring(response: 0.0, dampingFraction: 1, blendDuration: 0.5)) // Spring animation
                        
                }
            }

            
        }
        .padding()
    }
}

struct PhaseTwo: View {
    var selectedBeverage: Beverage
    
    @Binding var showPhaseTwo: Bool
    
    
    var body: some View {
        CoffeeInputView(beverageName: selectedBeverage.beverageName, beverageTag: selectedBeverage.bevereageType.uppercased(), showInputView: $showPhaseTwo)
            .navigationBarBackButtonHidden(true)
    }
}



struct PhaseOne: View {
    @ObservedObject var viewModel = BeverageViewModel()
    @State private var selectedType: String = "All" // default to "All"
    
    @Binding var selectedBeverage: Beverage?
    @Binding var showPhaseTwo: Bool
    
    // Add "All" to the list of unique bevereageType strings
    let beverageTypes = ["All", "coffee", "tea", "drink"]
    
    @Namespace private var animation // Namespace for matchedGeometryEffect
    
    var body: some View {
        VStack {
            // Display bevereageType options
            HStack {
                ForEach(beverageTypes, id: \.self) { type in
                    BeverageTypeButton(type: type, selectedType: $selectedType)
                        .padding(.horizontal, 10)
                }
            }
            
            Divider()
            
            Button{
                PopUpView().showAndStack()
            } label : {
                BeverageRow(title: "CUSTOM YOUR BEVERAGE")
            }
            
            ScrollView {
                ForEach(viewModel.beverages.filter { selectedType == "All" ? true : $0.bevereageType == selectedType }, id: \.self) { beverage in
                    BeverageRow(title: beverage.beverageName)
                        .onTapGesture {
                            selectedBeverage = beverage
                            showPhaseTwo = true
                        }
                }
                
            }
        }
        .onAppear {
            viewModel.addDefaultBeverages()
            viewModel.loadData()
        }
    }
}


struct BeverageTypeButton: View {
    var type: String
    @Binding var selectedType: String
    
    // This is a namespace for matchedGeometryEffect. You'll need to declare this in the parent view as well.
    @Namespace var animation
    
    var body: some View {
        Button(action: {
            withAnimation {
                selectedType = type
            }
        }) {
            Text(type.capitalized)
                .font(.custom("YourFontNameHere", size: 15)) // Replace "YourFontNameHere" with your actual font name
                .fontWeight(.semibold)
                .foregroundColor(selectedType == type ? Color.black : Color.gray)
                .padding(.bottom, 10)
                .overlay(
                    ZStack {
                        if selectedType == type {
                            Capsule()
                                .fill(Color.black)
                                .frame(height: 2)
                                .matchedGeometryEffect(id: "BEVERAGETAB", in: animation)
                        } else {
                            Capsule()
                                .fill(Color.clear)
                                .frame(height: 2)
                        }
                    }
                        .padding(.horizontal, -5)
                    , alignment: .bottom
                )
        }
    }
}



struct BeverageRow: View {
    var title: String
    
    var body: some View {
        
        HStack {
            Text(title.capitalizedFirstLetter)
            Spacer()
            Image(systemName: "chevron.right")
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(Color.onBackgroundTertiary)
        .cornerRadius(8)
    }
    
}


#Preview {
    //    BeverageListView(showInputView: .constant(true))
    BeverageListView()
}

//
//  CoffeeInputView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 2/10/2023.
//

import SwiftUI

struct CoffeeInputView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var beverageName : String
    var beverageTag : String
    
    @Binding var showInputView: Bool
    @State private var showDetails : Bool = false
    @State private var currentDate = Date()
    @State private var sliderValue: Double = 63  // Initialized with 0.5 * 63
    @State private var numberValue: Double = 1   // Initial value
    
    var body: some View {
        VStack {
            HStack{
                VStack(alignment: .leading)
                {
                    Text(beverageName)
                        .font(.largeTitle)
                }
                
                Spacer()
                
                Text(beverageTag)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.black))
            }
            
            HStack {
                Image(systemName: "clock")
                Text("Date")
                
                Spacer()
                
                DatePicker("", selection: $currentDate, displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(DefaultDatePickerStyle())
            }
            .padding(20)
            .background(Color.onBackgroundTertiary)
            .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Caffeine")
                Divider()
                
                HStack {
                    Text("Shots")
                        .padding(8)
                        .background(Color.onBackgroundTertiary)
                        .cornerRadius(8)
                    
                    Spacer()
                    
                    HStack(spacing: 10) {
                        Button(action: {
                            if numberValue > 0 {
                                numberValue -= 0.5
                                sliderValue = numberValue * 63
                            }
                        }) {
                            Image(systemName: "minus.square.fill")
                                .foregroundColor(numberValue > 0 ? Color.black : Color.gray)
                                .font(.system(size: 28))  // Increase button size
                        }
                        .disabled(numberValue <= 0) // Disable the button when numberValue is 0
                        
                        Text("\(numberValue, specifier: "%.1f")")
                            .frame(width: 50, alignment: .center)  // Fixed width to ensure alignment remains
                        
                        Button(action: {
                            numberValue += 0.5
                            sliderValue = numberValue * 63
                        }) {
                            Image(systemName: "plus.square.fill")
                                .foregroundColor(Color.black)
                                .font(.system(size: 28))  // Increase button size
                        }
                    }

                }

                
                HStack {
                    Spacer()
                    Text("More detail")
                    Image(systemName: "chevron.down")
                        .rotationEffect(.degrees(showDetails ? 180 : 0))
                    
                }
                .onTapGesture {
                    withAnimation {
                        showDetails.toggle()
                    }
                }
                .font(.caption)
                .foregroundColor(Color.gray)
                
                if showDetails {
                    VStack {
                        Slider(value: $sliderValue, in: 0...400, step: 1)
                            .onChange(of: sliderValue) { newValue in
                                numberValue = newValue / 63
                            }
                        
                        Text("Caffeine: \(Int(sliderValue))mg")
                    }
                }
            }
            .padding()
            .background(Color.yellow)
            .cornerRadius(8)
            
            
            
            Spacer()
            
            HStack{
                Spacer()
                
                Button(action: {
                

                    self.showInputView = false
                }) {
                    Text("ADD")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.black))
                }
                
            }
            
        }
        .navigationBarBackButtonHidden()
        .padding()
    }
}

#Preview {
    CoffeeInputView(beverageName: "Latte", beverageTag: "#COFFEE", showInputView: .constant(true))
        .environmentObject(ConsumptionViewModel())
}

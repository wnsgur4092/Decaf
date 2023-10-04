//
//  CoffeeInputView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 2/10/2023.
//

import SwiftUI

struct CoffeeInputView: View {
    @ObservedObject var viewModel = BeverageViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var beverageName : String
    @Binding var showInputView: Bool
    @State private var sliderValue: Double = 40
    
    @State private var coffeeName: String = ""
    @State private var isHot : Bool = true
    @State private var showDetails : Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 22, maxHeight: 22)
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                Spacer()
            }
            
            
            HStack{
                VStack{
                    Text("HOT")
                    Text(beverageName)
                }
                
                Spacer()
                
                Text("#COFFEE")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.black))
            }
            
            HStack{
                HStack{
                    Image(systemName: "clock")
                    Text("DATE")
                }
                
                Spacer()
                
                HStack{
                    Text("4 OCT 2023")
                    Text("10:44 pm")
                }
            }
            
            HStack{
                Text("SHOTS")
                
                Spacer()
                
                HStack{
                    Text("-")
                    Text("1")
                    Text("+")
                }
            }
            
            HStack{
                Text("More Detail")
                Spacer()
                Image(systemName: "chevron.down")
                    .rotationEffect(.degrees(showDetails ? 180 : 0))
                    .onTapGesture {
                        withAnimation {
                            showDetails.toggle()
                        }
                    }
            }
            
            if showDetails{
                VStack {
                    Slider(value: $sliderValue, in: 0...1000, step: 1)
                    
                    Text("Slider Value: \(Int(sliderValue))")
                }
                
            }
            
            Spacer()
            
            HStack{
                Spacer()
                
                Button(action: {showInputView = false}, label: {
                    Text("ADD")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.black))
                        .onTapGesture {
                            self.showInputView = false
                        }
                })
                
            }
            
        }
        .navigationBarBackButtonHidden()
        .padding()
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    CoffeeInputView(beverageName: "Latte", showInputView: .constant(true))
}

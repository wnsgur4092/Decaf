//
//  NewAddView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 7/7/2023.
//

import SwiftUI

struct CoffeeAddView: View {
    //MARK: - PROPERTIES
    @State var coffeeName : String
    @State var selectedSize : String = "S"
    @State var isHotSelected : Bool = true
    @State var numberOfShots : Double = 1.0
    
    var body: some View {
        VStack{
            ScrollView{
                VStack{
                    ImageView(image: isHotSelected ? "HotCoffee" :"IceCoffee")
                    
                    HotAndIcedSection(isHotSelecting: $isHotSelected)
                    
                    TextField("Coffee Name", text: $coffeeName)
                        .padding()
                        .overlay(
                            Image(systemName: "list.bullet.clipboard.fill")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.trailing), alignment: .trailing
                        )
                        .background(
                            RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 2)
                        )
                    
                    
                    SizeSelection(selectedSize: $selectedSize)
                    
                    ContentSection(contentImage: "coffeebean", contentName: "Shots", numberOfContent: $numberOfShots)
                    
                }
            }
            FooterView(beverageImageName: isHotSelected ? "HotCoffee" :"IceCoffee", beverageName: $coffeeName)
        }
        .onChange(of: selectedSize, perform: { value in
            adjustShotsBasedOnSize()
        })
        //        .background(Color("BackgroundColor").edgesIgnoringSafeArea(.all))
    }
    
    // whenever the selectedSize changes, adjust numberOfShots accordingly
    private func adjustShotsBasedOnSize() {
        switch selectedSize {
        case "S":
            numberOfShots = 1.0
        case "M":
            numberOfShots = 2.0
        case "L":
            numberOfShots = 3.0
        default:
            break
        }
    }
}



//MARK: - PROPERTIES
struct CoffeeAddView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeAddView(coffeeName: "Cappucino")
    }
}

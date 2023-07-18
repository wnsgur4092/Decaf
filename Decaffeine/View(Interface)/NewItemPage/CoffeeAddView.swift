//
//  NewAddView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 7/7/2023.
//

import SwiftUI

struct CoffeeAddView: View {
    //MARK: - PROPERTEIS
    let sizes : [String] = ["S", "M", "L"]
    @State var selectedSize = "Small"
    @State private var selectedSizeIndex = 0
    
    @State var coffeeName : String
    
    //MARK: - BODY
    var body: some View {
        VStack{
            ScrollView{
                VStack{
                    Image("HotCoffee")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                    
                    HotAndIcedSeclection()
                    
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
                    
                    
                    sizeSelection
                    
                    
                    VStack(alignment: .leading, spacing: 20) {
                        HStack{
                            Text("SHOTS")
                            
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Text("MORE..")
                            }
                            
                        }
                        
                        HStack {
                            Image("coffeeBean")
                            Image("coffeeBean")
                            Image("coffeeBean")
                            Image("coffeeBean")
                            
                            Spacer()
                            
                            HStack {
                                Button(action: {
                                    // decrease action
                                }) {
                                    Image(systemName: "minus.square")
                                }
                                
                                Text("1")
                                    .padding(.horizontal)
                                
                                Button(action: {
                                    // increase action
                                }) {
                                    Image(systemName: "plus.square")
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding() // Add some padding around the VStack
                    .background(
                        RoundedRectangle(cornerRadius: 10) // The rounded rectangle
                            .fill(Color.white) // Make it white
                    )
                    
                    
                    
                    
                    
                    
                    
                    
                }
            }
            
            HStack{
                Image("HotCoffee")
                    .resizable()
                    .scaledToFit()
                    .frame(width:44, height: 44)
                
        
                VStack{
                    Text(coffeeName)
                    
                    HStack{
                        Text("S")
                        
                        Text("156mg")
                    }
                }
                
                Spacer()
                
                Text("Save")
                     .padding() // Add some padding around the Text
                     .background(
                         RoundedRectangle(cornerRadius: 10) // The rounded rectangle
                             .fill(Color.black) // Make it black
                     )
                     .foregroundColor(.white) // Make the text white
            }
        }
        .background(Color("BackgroundColor").edgesIgnoringSafeArea(.all))
    }
    
    
    //MARK: - COMPONENT
    
    fileprivate var sizeSelection: some View {
        VStack(alignment: .leading){
            Text("SIZE")
            
            HStack(spacing: 40) {
                ForEach(Array(sizes.indices), id: \.self) { index in
                    
                    Button {
                        selectedSizeIndex = index
                    } label: {
                        Text(sizes[index])
                            .foregroundColor(.gray)
                            .padding(.vertical, 20)
                            .padding(.horizontal, 40)
                            .font(.system(size: 14).bold())
                            .overlay(
                                RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 2)
                            )
                    }
                }
            }
            .frame(maxWidth:.infinity)
        }
        .frame(maxWidth:.infinity)
        .padding() // Add some padding around the VStack
        .background(
            RoundedRectangle(cornerRadius: 10) // The rounded rectangle
                .fill(Color.white) // Make it white
        )
    }
}

struct HotAndIcedSeclection : View {
    var body : some View {
        HStack{
            Text("HOT")
                .frame(maxWidth: .infinity)
                .foregroundColor(.gray)
                .padding(.vertical, 20)
                .padding(.horizontal, 40)
                .font(.system(size: 14).bold())
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 2)
                )
            
            Spacer()
            
            Text("ICED")
                .frame(maxWidth: .infinity)
                .foregroundColor(.gray)
                .padding(.vertical, 20)
                .padding(.horizontal, 40)
                .font(.system(size: 14).bold())
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 2)
                )
        }
    }
}


//MARK: - PROPERTIES
struct CoffeeAddView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeAddView(coffeeName: "Cappucino")
    }
}

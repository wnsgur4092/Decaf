//
//  NewAddView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 7/7/2023.
//

import SwiftUI

struct NewAddView: View {
    //MARK: - PROPERTEIS
    let sizes : [String] = ["S", "M", "L"]
    @State var selectedSize = "Small"
    @State private var selectedSizeIndex = 0
    
    @State var coffeeName : String
    
    //MARK: - BODY
    var body: some View {
        ScrollView{
            VStack{
                Image("HotCoffee")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                
                HStack{
                    Text("HOT")
                    
                    Spacer()
                    
                    Text("ICED")
                }

                HStack{
                    TextField("Coffee Name", text: $coffeeName)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 2)
                        )
                    
                    Image(systemName: "list.bullet.clipboard.fill")
                }
                
                sizeCell
                
                
                VStack{
                    Text("SHOTS")
                    
                    HStack{
                        Text("4")
                        
                        Image(systemName: "plus")
                        Image(systemName: "minus")
                    }
                }
                
            }
        }
        .padding(.horizontal, 20)
        .background(Color("BackgroundColor"))
    }
    
    
    //MARK: - COMPONENT
    fileprivate var sizeCell : some View {
        VStack{
            Text("SIZE")
            
            HStack(spacing: 28) {
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
        }
    }
}


//MARK: - PROPERTIES
struct NewAddView_Previews: PreviewProvider {
    static var previews: some View {
        NewAddView(coffeeName: "Cappucino")
    }
}

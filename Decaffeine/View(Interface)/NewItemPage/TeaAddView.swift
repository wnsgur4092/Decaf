//
//  TeaAddView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 18/7/2023.
//

import SwiftUI

struct TeaAddView: View {
    //MARK: - PROPERTEIS
    let sizes : [String] = ["S", "M", "L"]
    @State var selectedSize = "Small"
    @State private var selectedSizeIndex = 0
    
    @State var teaName : String
    
    //MARK: - BODY
    var body: some View {
        ScrollView{
            VStack{
                Image("HotTea")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                
                HStack{
                    Text("HOT")
                    
                    Spacer()
                    
                    Text("ICED")
                }

                HStack{
                    TextField("Coffee Name", text: $teaName)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 2)
                        )
                    
                    Image(systemName: "list.bullet.clipboard.fill")
                }

                
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
        .background(Color("BackgroundColor").edgesIgnoringSafeArea(.all))
    }
    //MARK: - COMPONENT

}

//MARK: - PREVIEW
struct TeaAddView_Previews: PreviewProvider {
    static var previews: some View {
        TeaAddView(teaName: "Black Tea")
    }
}

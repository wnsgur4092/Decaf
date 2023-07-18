//
//  DrinkAddView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 18/7/2023.
//

import SwiftUI

struct DrinkAddView: View {
    @State var drinkName : String
    
    //MARK: - BODY
    var body: some View {
        ScrollView{
            VStack{
                Image("Drink")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
            

                HStack{
                    TextField("Coffee Name", text: $drinkName)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 2)
                        )
                    
                    Image(systemName: "list.bullet.clipboard.fill")
                }

                
            }
        }
        .padding(.horizontal, 20)
        .background(Color("BackgroundColor").edgesIgnoringSafeArea(.all))
    }
    //MARK: - COMPONENT

}

struct DrinkAddView_Previews: PreviewProvider {
    static var previews: some View {
        DrinkAddView(drinkName: "Redbull")
    }
}

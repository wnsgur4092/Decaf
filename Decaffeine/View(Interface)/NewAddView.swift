//
//  NewAddView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 7/7/2023.
//

import SwiftUI

enum Coffee: String, CaseIterable, Identifiable {
    case Espresso
    case LongBlack
    case Macchiato
    // add more coffee types here as needed

    var id: String { self.rawValue }
}

struct NewAddView: View {
    //MARK: - PROPERTEIS
    
    //MARK: - BODY
    var body: some View {
        ScrollView{
            Image("Coffee")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 150)
            
            VStack{
                Text("Type")
                
                HStack{
                    ForEach(Coffee.allCases) { coffee in
                        Text(coffee.rawValue)
                    }
                }
            }
            
        }
        .background(Color("BackgroundColor"))
    }
    
}


struct NewAddView_Previews: PreviewProvider {
    static var previews: some View {
        NewAddView()
    }
}

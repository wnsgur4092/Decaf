//
//  SettingUIView.swift
//  Decaffeine
//
//  Created by Stella Hung on 22/2/2023.
//

import SwiftUI

struct SettingView: View {
    
    //PROPERTIES
    @State var isPresentingPrivacyView = false
    
    
    //BODY
    var body: some View {
        ScrollView{
            header
                .padding(.vertical,12)
                .padding(.horizontal, 32)
            
            Divider()
                .padding(.bottom, 10)
            
            VStack{
                
            }
        }
    }
    
    // COMPONENTS
    fileprivate var header : some View {
        HStack(alignment: .center) {
            Text("Setting")
                .font(.system(size: 32))
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct SettingUIView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

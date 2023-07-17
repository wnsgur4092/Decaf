//
//  LogoView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 17/7/2023.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        HStack(spacing:4) {
            Image("large")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30, alignment: .center)
            
            Text("Decaf".uppercased())
                .font(.title3)
                .fontWeight(.black)
                .foregroundColor(.black)
            
            Text("".uppercased())
                .font(.title3)
                .fontWeight(.black)
                .foregroundColor(.black)
        } //: HSTACK
    }
}

//MARK: - PREVIEW
struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView().previewLayout(.sizeThatFits).padding()
    }
}


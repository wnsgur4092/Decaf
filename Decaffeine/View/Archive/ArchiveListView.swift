//
// ContentView.swift
// coffeeearchive
//
// Created by Sahar Asad Osmani on 15/2/2023.
//

import SwiftUI

struct ArchiveListView: View {
    
var body: some View {
    
    VStack (spacing: 10){
        HStack {
            Text("Time")
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .opacity(0.4)
                .frame(alignment: .leading)
                .padding(.trailing, 50)
            
            Text("Caffeine")
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .opacity(0.4)
                .frame(maxWidth: .infinity,
                       alignment: .leading)
        }
            .padding(.bottom, 10)
        
        HStack (alignment: .top, spacing: 5)  {
            Text("11:35")
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: 80,
                       alignment: .topLeading)
                           
            VStack {
                Text("Cappuccino")
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity,
                           alignment: .leading)
                    .padding(.bottom, 15)
            
                
                Text("Large")
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity,
                           alignment: .leading)
                    .padding(.bottom, 5)

                Text("2 Shots")
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity,
                           alignment: .leading)
            }
            .font(.subheadline)
            .padding(15)
            .frame(maxWidth: .infinity,
                   alignment: .leading)
            .background(RoundedRectangle(cornerRadius: 20).fill(Color("mainColor")))
        }
        
        HStack (alignment: .top, spacing: 5)  {
            Text("11:35")
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: 80,
                       alignment: .topLeading)
                           
            VStack {
                Text("Cappuccino")
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity,
                           alignment: .leading)
                    .padding(.bottom, 15)
         
                
                Text("Large")
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity,
                           alignment: .leading)
                    .padding(.bottom, 5)

                Text("2 Shots")
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity,
                           alignment: .leading)
            }
            .font(.subheadline)
            .padding(15)
            .frame(maxWidth: .infinity,
                   alignment: .leading)
            .background(RoundedRectangle(cornerRadius: 20).fill(Color("mainColor")))
        }
        
        HStack (alignment: .top, spacing: 5)  {
            Text("11:35")
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: 80,
                       alignment: .topLeading)
                           
            VStack {
                Text("Cappuccino")
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity,
                           alignment: .leading)
                    .padding(.bottom, 15)
 
                
                Text("Large")
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity,
                           alignment: .leading)
                    .padding(.bottom, 5)

                Text("2 Shots")
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity,
                           alignment: .leading)
            }
            .font(.subheadline)
            .padding(15)
            .frame(maxWidth: .infinity,
                   alignment: .leading)
            .background(RoundedRectangle(cornerRadius: 20).fill(Color("mainColor")))
        }
        
        Spacer()
    }

    }
}


struct ArchiveListView_Previews: PreviewProvider {
    static var previews: some View {
        ArchiveListView()
    }
}

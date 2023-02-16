//
// ContentView.swift
// coffeeearchive
//
// Created by Sahar Asad Osmani on 15/2/2023.
//

import SwiftUI

struct ArchiveListView: View {
    
var body: some View {
    
    let maxCaffeine = 2000
    let currentCaffeine = 2000

    VStack (spacing: 10){
        Text("Archive")
            .font(.largeTitle)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity,
                   alignment: .leading)

        HStack (spacing: 10){
            Text("Total Caffeine")
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity,
                       alignment: .leading)
            Group {
                Text("\(currentCaffeine) ")
                    .foregroundColor(currentCaffeine > maxCaffeine ? .red : currentCaffeine < maxCaffeine ? .purple : .blue)
                + Text ("/ \(maxCaffeine)")
            }
            .multilineTextAlignment(.trailing)
            .font(.subheadline)
            .padding(15)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 1)
                )
        }
        
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
            .background(RoundedRectangle(cornerRadius: 20).fill(Color.purple))
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
            .background(RoundedRectangle(cornerRadius: 20).fill(Color.purple))
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
            .background(RoundedRectangle(cornerRadius: 20).fill(Color.purple))
        }
        
        Spacer()
    }
        .padding(.leading,30)
        .padding(.trailing, 30)

    }
}


struct ArchiveListView_Previews: PreviewProvider {
    static var previews: some View {
        ArchiveListView()
    }
}

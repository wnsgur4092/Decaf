//
//  AnnouncementView.swift
//  Holder for Announcements
//
//  Created by Vandan Raisinghani on 22/2/2023.
//

import SwiftUI

struct AnnouncementsListView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isNewsInfoVisible = false // 1. 토글 상태 변수 추가
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            header
                .padding(.vertical,32)
            
            updateNews
            
            if isNewsInfoVisible {
                newsInfo
    
            }
            
            
            Spacer()
        }
        .padding(.horizontal, 32)
    }
    fileprivate var header: some View{
        HStack{
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color("mainColor"))
                    .frame(width: 20,height: 20)
            }
            
            Spacer()
        }
    }
    fileprivate var updateNews: some View{
        VStack{
            HStack{
                Text("Version 1.0 Updated")
                    .fontWeight(.semibold)
                Spacer()
                Text("24.02.2023")
                    .fontWeight(.semibold)
                Image(systemName: "chevron.down")
                    .rotationEffect(isNewsInfoVisible ? .degrees(180) : .degrees(0)) // 1. 로테이션 효과 추가
                               .animation(.easeInOut) // 2. 애니메이션 효과 추가
                
         
            }
            .font(.system(size: 16))
            .onTapGesture {
                isNewsInfoVisible.toggle()
            }
            
            Divider()
        }
    }
    
    fileprivate var newsInfo : some View{
        VStack(alignment: .leading, spacing: 20){
            Text("Announcement of Version 1.0 Released")
                .padding(.top, 16)
                .padding(.horizontal, 10)
            
            Text("Successfully Released version 1.0")
                .padding(.horizontal, 10)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 200)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(Color("mainColor").opacity(0.5), lineWidth: 1)
        )
        .animation(.easeInOut(duration: 1))
        
    }
}


struct AnnouncementsListView_Previews: PreviewProvider {
    static var previews: some View {
        AnnouncementsListView()
    }
}


//
//  SettingUIView.swift
//  Decaffeine
//
//  Created by Stella Hung on 22/2/2023.
//

import SwiftUI

struct SettingView: View {
    
    //PROPERTIES
    @State var isPresentingAnnouncementView = false
    
    
    //BODY
    var body: some View {
        ScrollView{
            header
                .padding(.vertical,12)
                .padding(.horizontal, 32)
            
            Divider()
                .padding(.bottom, 10)
            
            VStack(spacing: 20){
                settingList
                
                versionList
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 10)
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
    
    fileprivate var settingList : some View {
        VStack {
            HStack {
                Text("Announcement")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            .onTapGesture {
                isPresentingAnnouncementView = true
            }
            .fullScreenCover(isPresented: $isPresentingAnnouncementView) {
                AnnouncementsListView()
            }
            Divider()
            
        }
    }
    
    fileprivate var versionList : some View {
        HStack{
            VStack(alignment: .leading){
                Text("Version")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                Text("Latest Version")
                    .font(.system(size: 12))
            }
 
            
            Spacer()
            
            Text("1.0")
        }
    }
    
}

struct SettingUIView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

//
//  SettingProfileView.swift
//  Decaffeine
//
//  Created by Stella Hung on 21/2/2023.
//

import SwiftUI

struct SettingProfileView: View {
    
    @State var isSubpageActive:Bool = false
    @State var activePage:String = ""
    
    var body: some View {
        
       /* VStack {
            Image("defaultProfileImage")
                .resizable()
                .frame(maxWidth: 100, maxHeight: 100, alignment: .center)
                .padding()
            
            VStack (alignment: .leading){
                Text("Jun Casenova")
                
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                
                Spacer()
                    .frame(maxWidth: 50, maxHeight: 6)
                Text("Member since Feb 2023")
                    .font(.system(size: 14))
                    .fontWeight(.light)
                    .foregroundColor(Color.gray)
            }*/
            List {
                ForEach(0..<settingItems.count) { index in
                    Label(settingItems[index].name, systemImage: settingItems[index].icon)
                        .font(.body)
                        .onTapGesture(count: 1, perform: {
                            activePage = settingItems[index].viewName
                            isSubpageActive.toggle()
                        })
                }
                Spacer()
            }
            .fullScreenCover(isPresented: $isSubpageActive, onDismiss: { activePage = ""
            }, content: {
                VStack {
                    switch activePage {
                    case "TermsView": TermsOfServiceView()
                    case "PrivacyPolicy": PrivacyPolicyView()
                    case "Announcement": AnnouncementPage()
                    
                    default:
                        Text("Work in progress!")
                   
                    }
                    Button("Close full screen page"){
                        isSubpageActive.toggle()
                    }
                    
                }
                
            })
       
        }
    }
        
        struct TermsOfServiceView: View {
            var body: some View {
                VStack {
                    Text("Terms of Services")
                        .font(.largeTitle)
                    Text("Use the app responsibly")
                        .font(.body)
                } .padding()
            }
            
        }
struct PrivacyPolicyView: View {
    var body: some View {
        VStack {
            Text("Privacy Policy")
                .font(.largeTitle)
            Text("Here are the privacy policy to be followed")
                .font(.body)
        } .padding()
    }
    
}

struct AnnouncementPage: View {
    var body: some View {
        VStack{
            Text("Announcement")
                .font(.largeTitle)
            Text("This is the announement page")
                .font(.body)
            
        }
    }
}

    


        
        struct SettingProfileView_Previews: PreviewProvider {
            static var previews: some View {
                SettingProfileView()
            }
        }
    

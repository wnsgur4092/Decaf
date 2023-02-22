//
//  SettingUIView.swift
//  Decaffeine
//
//  Created by Stella Hung on 22/2/2023.
//

import SwiftUI

struct SettingUIView: View {
    @State var isPresentingPrivacyView = false
    var body: some View {
        
        NavigationView{
            
            List {
                
                    NavigationLink {
                        PrivacyPolicyView()
                    } label: {
                        Text("Privacy Policy")
                    }
             
                   
                        NavigationLink {
                            AnnouncementView()
                        } label: {
                            Text("Announcement")
                        }
                 
                        NavigationLink {
                            TermsOfServiceView()
                        } label: {
                            Text("Terms and Conditions")
                        }
                
            }
            
            .navigationBarTitle("Settings")
            .offset(x:-5)
            
            
        }
    }
}

struct SettingUIView_Previews: PreviewProvider {
    static var previews: some View {
        SettingUIView()
    }
}

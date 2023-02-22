//
//  AnnouncementsListView.swift
//  Decaffeine
//
//  Created by Vandan Raisinghani on 22/2/2023.
//

import SwiftUI

struct AnnouncementsListView: View {
    @State var isPresentingAnnouncementView = false
    @State var isPresentingBackView = false
    var body: some View {
        VStack{
            //Header
            VStack{
                header
                    .padding(.top,55)
                    .padding(.bottom,15)
                bottombit
                Spacer()
                    .frame(height:550)
            }
        }
        .frame(maxWidth:.infinity, maxHeight: .infinity)
        .background(Color(.white))
        .edgesIgnoringSafeArea(.all)
    }
    fileprivate var header: some View{
        HStack{
            Spacer()
                .frame(width:20)
            Button{
                isPresentingBackView = true
            } label:{
                Image(systemName: "chevron.left")
                    .opacity(0.8)
            }
            .fullScreenCover(isPresented: $isPresentingBackView){
                SettingView()
            }
            Text("Announcements")
                .fontWeight(.semibold)
        }
        .frame(maxWidth:.infinity, alignment: .leading)
        .font(.system(size:32))
        .foregroundColor(.black)
    }
    fileprivate var bottombit: some View{
        ZStack{
            Rectangle()
                .fill(.white)
                .frame(maxWidth:.infinity, maxHeight:.infinity)
            VStack{
                    Button{
                       isPresentingAnnouncementView = true
                    } label:{
                        HStack{
                            Text("Version 1.1 Updated")
                            Spacer()
                            Text("7.03.2023")
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(.black)
                    }
                    .fullScreenCover(isPresented:$isPresentingAnnouncementView){
                        AnnouncementView()
                    }
                
                Rectangle()
                    .frame(height:2)
                Spacer()
                    .frame(height:30)
                Button{
                    isPresentingAnnouncementView = true
                } label: {
                    HStack{
                        Text("Version 1.0 Released")
                        Spacer()
                        Text("7.03.2023")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.black)
                }
                .fullScreenCover(isPresented: $isPresentingAnnouncementView){
                    AnnouncementView()
                }
                Rectangle()
                    .frame(height:2)
            }
            .padding()
            .font(.system(size:20))
        }
    }
}

struct AnnouncementsListView_Previews: PreviewProvider {
    static var previews: some View {
        AnnouncementsListView()
    }
}


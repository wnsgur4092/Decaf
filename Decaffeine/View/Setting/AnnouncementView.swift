//
//  AnnouncementView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 13/2/2023.
//

import SwiftUI

struct AnnouncementView: View {
    //PROPERTIES
    var title : String = ""
    var date : String = ""
    var description : String = ""
    var subdescription : String = ""
    
    //BODY
    var body: some View {
        //        VStack(alignment: .leading){
        //            HStack{
        //                Text("Version 1.1 Updated")
        //                Spacer()
        //                Text("07.03.2023")
        //
        //            }
        //            .font(.system(size:20))
        //
        //            Rectangle()
        //                .frame(height:2)
        //                .foregroundColor(.gray)
        //            Text("Announcement of Version 1.1 Update")
        //                .offset(CGSize(width:0,height: 20))
        //            Text("Update the issue, which can't delete one of caffeine lists")
        //                .offset(CGSize(width:0,height:40))
        //            Spacer()
        //
        //        }
        //        .padding(.horizontal, 32)
        
        VStack(alignment: .leading){
            HStack{
                Text(title)
                Spacer()
                Text(date)
                
            }
            .font(.system(size:20))
            
            Rectangle()
                .frame(height:2)
                .foregroundColor(.gray)
            Text(description)
                .offset(CGSize(width:0,height: 20))
            Text(subdescription)
                .offset(CGSize(width:0,height:40))
            Spacer()
            
        }
        .padding(.horizontal,32)
    }
}

struct AnnouncementView_Previews: PreviewProvider {
    static var previews: some View {
        AnnouncementView(title: "ABC", date: "00", description: "", subdescription: "A")
    }
}

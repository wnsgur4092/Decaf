//
//  OnBoardingProfileView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 13/2/2023.
//

import SwiftUI

struct OnBoardingProfileView: View {
    //MARK: - PROPERTIES
    @State var name : String = ""
    
    //MARK: - BODY
    //1. @FocusState
    //2. Rectangle Background on Image
    //3. Profile Image Selected

    var body: some View {
        NavigationView {
            VStack{
                Text("Setting Profile")
                
                Image("defaultProfileImage")
                
                VStack{
                    Text("Name")
                    
                    TextField("Enter Your Name", text: $name)
                        .textFieldStyle(.roundedBorder)
                    
    
                    Text("Gender")
                    Text("Caffeine ingestion is different by gender ")
                    
                    HStack(spacing: 40){
                        VStack{
                            Image("female")
                            Text("400mg")
                        }

                        VStack{
                            Image("male")
                            Text("400mg")
                        }
                    }

                    Button {
                        print("Next Button Tapped")
                    } label: {
                        ZStack{
                            Text("Next")
                                .foregroundColor(.white)
                                .zIndex(1)

                            RoundedRectangle(cornerRadius: 11)
                                .frame(width: 146, height: 56, alignment: .center)
                        }
                         
                    } //: BUTTON
                    .padding(.top, 12)

                }
            }
        }
    }
}

struct OnBoardingProfileView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingProfileView()
    }
}

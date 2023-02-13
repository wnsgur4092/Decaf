//
//  OnBoardingProfileView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 13/2/2023.
//

import SwiftUI
import PhotosUI

struct OnBoardingProfileView: View {
    //MARK: - PROPERTIES
    @StateObject var vm = ProfileViewModel()
    

    //MARK: - BODY
    //1. @FocusState
    //2. Rectangle Background on Image
    //3. Profile Image Selected
    
    var body: some View {
        VStack(spacing: 20) {
            //HEADER + PROFILE IMAGE
            VStack {
                header
                    .padding(.bottom, 24)
                
                profileImage
            }
            .padding(.top, 60)
            .padding(.horizontal, 32)
            
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    
                    userSection
                    
                    Spacer()
                    
                    nextButton
                        .padding(.bottom, 60)
                        .padding(.top, 12)
                }
                .padding(.horizontal,32)
                
            }
            .background(
                Color.white
                    .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 33))
                    .ignoresSafeArea()
            )
            
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("mainColor"))
        .edgesIgnoringSafeArea(.all)
    }
    
    //MARK: - COMPONENTS
    
    //HEADER
    fileprivate var header : some View {
        HStack(alignment: .center) {
            Text("Setting Profile")
                .font(.system(size: 32))
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    //PROFILE IMAGE
    fileprivate var profileImage : some View {
        ZStack{
            vm.image!
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 0.5))
            
            
            Image(systemName: "camera.fill")
                .renderingMode(.original)
                .resizable()
                .foregroundColor(.white)
                .frame(width: 24, height: 20)
                .background(Circle().fill(Color.blue).frame(width:40,height:40))
                .offset(x: 40, y: 42)
        }
        .onTapGesture(perform: {
            vm.presentedActionSheet = true
        })
        .sheet(isPresented: $vm.presentImagePicker, content: {
            SUImagePickerView(sourceType: vm.presentCamera ? .camera : .photoLibrary, image: $vm.image, isPresented: $vm.presentImagePicker)
        })
        .actionSheet(isPresented: $vm.presentedActionSheet) {
            ActionSheet(title: Text("Set Profile Image"), buttons:[
                .default(Text("Camera")) {
                    vm.presentImagePicker = true
                    vm.presentCamera = true
                },
                .default(Text("Album")) {
                    vm.presentImagePicker = true
                    vm.presentCamera = false
                },
                .cancel()])
        }
    }
    
    //USER SECTION
    fileprivate var userSection : some View {
        VStack(alignment: .leading){
            //NAME
            Text("Name")
                .font(.system(size: 18).bold())
                .padding(.top, 32)
            
            //NAME TEXTFIELD
            CustomTextField(placeholder: "Enter Your Name", name: vm.name, isFocusing: vm.isNameFoucsed)
                .padding(.bottom, 12)
            
            //GENDER
            Text("Gender")
                .font(.system(size: 18).bold())
                .padding(.bottom, 1)
            
            Text("Caffeine ingestion is different by gender")
                .font(.system(size: 14))
                .opacity(0.4)
            
            //GENDER IMAGE
            HStack(spacing: 60) {
                //FEMALE VSTACK
                VStack {
                    ZStack{
                        Image("female")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 120)
                        
                        
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color("gray"), lineWidth: 1)
                            .frame(width: 120, height: 120)
                    }
                    
                    Text("800mg/day")
                        .font(.system(size: 12, weight: .light))
                        .opacity(0.4)
                } //: FEMALE VSTACK
                
                //MALE VSTACK
                VStack {
                    ZStack{
                        Image("male")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 120)
                        
                        
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color("gray"), lineWidth: 1)
                            .frame(width: 120, height: 120)
                    }
                    Text("800mg/day")
                        .font(.system(size: 12, weight: .light))
                        .opacity(0.4)
                }
                //: MALE VSTACK
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    //BUTTON
    fileprivate var nextButton : some View {
        Button {
            print("next button tapped")
        } label: {
            Text("Next")
        }
        .buttonStyle(DisableButtonStyle())
        
    }
}

struct OnBoardingProfileView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingProfileView()
    }
}

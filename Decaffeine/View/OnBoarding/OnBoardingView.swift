//
//  OnBoardingView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 13/2/2023.
//

import SwiftUI
import Lottie

struct OnBoardingView: View {
    //MARK: - PROPERTIES
    @AppStorage("isOnboarding") var isOnboarding : Bool?
    
    var body: some View {
        VStack {
            VStack {
                
                lottieAnimationView
                    .padding(.top, 60)
                
                onBoardingText
                
                
                Spacer()
                
                //BUTTON
                getStartButton
                    .padding(.bottom, 60)
            } //: VSTACK
            .padding(.horizontal, 32)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
    
    //MARK: - COMPONENTS
    
    //Lottie Image
    fileprivate var lottieAnimationView : some View {
        LottieView(filename: "Coffee")
            .frame(maxWidth: 300, maxHeight: 300)
    }
    
    //Text
    fileprivate var onBoardingText : some View {
        VStack(alignment: .leading, spacing: 32){
            Text("Track your Caffeine")
                .font(.system(size: 28, weight: .bold))
            
            
            Text("Give up bad caffeine intake habits decreasing your well-being and become a better version of you")
                .font(.system(size: 18, weight: .semibold))
                .opacity(0.8)
            
            
            
            Text("The guided average total caffeine ingestion is referenced by the World Health Organisation")
                .font(.system(size: 16, weight: .regular))
                .opacity(0.6)
            
        }
        .foregroundColor(.black)
        .multilineTextAlignment(.leading)
    }
    
    fileprivate var getStartButton : some View {
        Button {
            print("Next Button Tapped")
            isOnboarding = false
        } label: {
            HStack(alignment: .center, spacing: 20){
                Text("Get Started")
                Image(systemName: "chevron.right")
            }
            .font(.system(size: 16))
            
        }
        .buttonStyle(ActiveButtonStyle())
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}

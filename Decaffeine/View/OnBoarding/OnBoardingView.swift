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
        LottieView(filename: "coffee")
            .frame(maxWidth: 300, maxHeight: 300)
    }
    //Text
    fileprivate var onBoardingText : some View {
        VStack(alignment: .leading, spacing: 32){
            Text("Track your Caffeine")
                .font(.systemFontBold(size: 28))
//                .font(.system(size: 28, weight: .bold))
            
            
            Text("Give up bad caffeine intake habits decreasing your well-being and become a better version of you")
                .font(.systemFontRegular(size: 20))
                .opacity(0.8)
            
            
            
            Text("The guided average total caffeine ingestion is referenced by the WHO")
                .font(.systemFontRegular(size: 16))
                .opacity(0.6)
            
        }
        .foregroundColor(.black)
        .multilineTextAlignment(.leading)
    }
    
    fileprivate var getStartButton: some View {
        Button {
            print("Next Button Tapped")
            isOnboarding = false
        } label: {
            HStack(alignment: .center, spacing: 20) {
                Spacer()
                Text("Get Start")
                    .padding(.leading, 20)
                Image(systemName: "chevron.right")
                Spacer()
            }
            .font(.systemFontBold(size: 20))
        }
        .buttonStyle(ActiveButtonStyle())
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}

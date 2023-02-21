//
//  CarouselObjectV2.swift
//  Decaf
//
//  Created by Jordan Pazdjara on 21/2/2023.
//

import SwiftUI

struct CarouselView: View {
    
    @State var currentImageIndicator : Int = 1
    @StateObject var homeViewModel  = HomeViewModel()
    
    var body: some View {
        VStack {
            TabView(selection: $currentImageIndicator) {
                ForEach(homeViewModel.list) { num in
                    
                    //MARK: start geometry
                    
                    GeometryReader { proxy in
                        let scale = getScale(proxy: proxy)
                        
                        ZStack {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(minWidth: 117, maxWidth: 250, minHeight: 195, maxHeight: 250)
                            VStack(spacing: 8) {
                                Image(num.imageName)
                                    .padding()
                                
                                Text(num.name)
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                                    .opacity(getOpacity(for: proxy))
                                
                            }
                        } //End ZStack
                        
                        .scaleEffect(.init(width: scale, height: scale)) //scale is found in getScale function below
                        .animation(.easeOut, value: 1)
                        .scaledToFill()
                        .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
                        
                    }
                    
                    //MARK: End geometry
                    
                    .padding(.horizontal, 64)
                    .padding(.vertical, 32)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            //Custom Image Indicator
            
            CustomIndicator(count: homeViewModel.list.count, current: $currentImageIndicator)
        }
    }
    
    func getScale(proxy: GeometryProxy) -> CGFloat {
        
        let midPoint: CGFloat = UIScreen.main.bounds.width / 2.75
        
        let viewFrame = proxy.frame(in: CoordinateSpace.global)
        
        var scale: CGFloat = 1.0
        let deltaXAnimationThreshold: CGFloat = 125
        
        
        let diffFromCenter = abs (midPoint - viewFrame.origin.x - deltaXAnimationThreshold / 2)
        if diffFromCenter < deltaXAnimationThreshold {
            scale = 1 + (deltaXAnimationThreshold - diffFromCenter) / 500
        }
        
        return scale
    }
    
    //MARK: getOpacity is for reading where the user scrolls then making the text opacity change
    
    func getOpacity(for geometry: GeometryProxy) -> Double {
        
        let minX = geometry.frame(in: .global).minX
        let maxX = geometry.frame(in: .global).maxX
        let midX = (minX + maxX) / 2
        
        let distance = abs(midX - UIScreen.main.bounds.width / 2)
        let maxDistance = UIScreen.main.bounds.width / 4
        
        let opacity = 1 - distance / maxDistance
        return max(0, min(1, opacity))
    }
    
    

}



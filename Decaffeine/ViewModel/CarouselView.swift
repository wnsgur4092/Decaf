//
//  CarouselObjectV2.swift
//  Decaf
//
//  Created by Jordan Pazdjara on 21/2/2023.
//

import SwiftUI

struct CarouselView: View {
    
    @State var currentImageIndicator : Int = 0
    @StateObject var homeViewModel  = HomeViewModel(storage: SelectedBeverageStroage())
    
    var body: some View {
        VStack {
            TabView(selection: $currentImageIndicator) {
                ForEach(homeViewModel.list.indices, id: \.self) { index in
                    
                    GeometryReader { proxy in
                        let scale = getScale(proxy: proxy)
                        
                        VStack(alignment: .center, spacing: 8) {
                            Image(homeViewModel.list[index].imageName)
                                .frame(width: 120, height: 200)
                                .padding(12)
                            
                            Text(homeViewModel.list[index].name)
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .opacity(getOpacity(for: proxy))
                        }
                        .scaleEffect(.init(width: scale, height: scale))
                        .animation(.easeOut, value: 1)
                        .scaledToFill()
                        .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
                    }
                    .padding(.horizontal, 64)
                    .padding(.vertical, 32)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
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



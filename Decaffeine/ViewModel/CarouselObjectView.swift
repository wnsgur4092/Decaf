//
//  CarouselObject.swift
//  Decaffeine
//
//  Created by Jordan Pazdjara on 20/2/2023.
//

import SwiftUI

struct CarouselObject: View {
    
    var body: some View {
        VStack {
            Spacer()
                .frame(maxWidth: 32, maxHeight: 32)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack (alignment: .top, spacing: 16) {
                    ForEach(coffeeTypes) { num in
                        
                        //MARK: start geometry
                        
                        GeometryReader { proxy in
                            let scale = getScale(proxy: proxy)
                            
                            //I think I put this navigation view in the wrong spot
                            //And I think we should create a new view the exact same as beverage addviewmodel for users to change the coffee or delete it.
                            
                            NavigationLink(
                                destination:
                                    BeverageDetailCell(detailImageName: "longblack", detailName: "Long Black", detailExtra: "Large")
                                , label: {
                                    ZStack {
                                        Rectangle()
                                            .fill(Color.clear)
                                            .frame(minWidth: 117, maxWidth: 250, minHeight: 195, maxHeight: 250)
                                        VStack(spacing: 8) {
                                            Image(num.imageName)
                                                .padding()
                                            
                                            Text(num.title)
                                                .font(.system(size: 18, weight: .bold))
                                                .foregroundColor(.black)
                                                .multilineTextAlignment(.center)
                                                .opacity(getOpacity(for: proxy))
                                            
                                        }
                                    } //End ZStack
                                    
                                    //MARK: This is where I tried to offset the carousel using the function I made down below.
                                    
//                                    .offset(x: )
                                    
                                })//end NavigationLink

                            .scaleEffect(.init(width: scale, height: scale)) //scale is found in getScale function below
                            .animation(.easeOut, value: 1)
                            .scaledToFill()
                            .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
                            
                        }
                        
                        //MARK: End geometry

                        .padding(.horizontal, 64)
                        .padding(.vertical, 32)
                    }

                } //end HStack
            } //end ScrollView
        } // end Vstack
    }
    
    //MARK: getScale is for scaling the images in the middle of the screen
    
    func getScale(proxy: GeometryProxy) -> CGFloat {
        
        let midPoint: CGFloat = UIScreen.main.bounds.width / 1.5
        
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
    
        //MARK: Start of Offset function
        //this function is for finding the total length of the carousel and offseting it based on that, it uses string length
    
//    func getWidth() -> CGFloat {
//
//        let totalWidth = coffeeTypes.reduce(0) { result, proxy in
//
//            let width = coffeeTypes.widthofString(usingFont: UIFont.boldSystemFont(ofSize: 28))
//
//            return result + CGFloat(width) + 20 // Add spacing between items
//        }
//
//        return totalWidth
//
//    }
    
    //MARK: End of Offset Function
    //Theres still an extension below that's important though
    
    
} //End of CarouselObject: View


        //MARK: Start of Offset Extension
        // This is needed so I can refer above "coffeeTypes.widthofString", but it still won't work :(

extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
        
    }
}

    //MARK: End of Offset Extension

struct CarouselObject_Previews: PreviewProvider {
    static var previews: some View {
        CarouselObject()
    }
}

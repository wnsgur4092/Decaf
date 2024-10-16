//
//  LottieView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 13/2/2023.
//

import Lottie
import SwiftUI
import UIKit

struct LottieView: UIViewRepresentable {
    
    typealias UIViewType = UIView
    var filename: String

    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {

        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView()
        animationView.animation = LottieAnimation.named(filename)
  
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {

    }
    
}

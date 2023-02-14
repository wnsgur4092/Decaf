//
//  CustomNavigationView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 15/2/2023.
//

import SwiftUI
import UIKit

struct CustomNavigationView : UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.navigationBar.barTintColor = UIColor(Color("mainColor"))
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return navigationController
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {

    }

}

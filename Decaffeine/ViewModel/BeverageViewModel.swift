//
//  BeverageViewModel.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 29/1/2023.
//
//
import Foundation
import SwiftUI

class BeverageViewModel: ObservableObject {
    @Published var beverageList: [Beverage] = Beverage.beverageList
}


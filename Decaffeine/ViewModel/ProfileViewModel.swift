//
//  ProfileViewModel.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 14/2/2023.
//

import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    //MARK: - PROPERTIES
    
    //Name Properties
    @Published var name : String = ""
    @Published var isNameFoucsed : Bool = false
    
    //Profile Image Properties
    @Published var image : Image? = Image("defaultProfileImage")
    @Published var presentImagePicker = false
    @Published var presentCamera = false
    @Published var presentedActionSheet = false
    
    //Gender Image Properties
    @Published var isFemaleSelected : Bool = false
    @Published var isMaleSelected : Bool = false
}

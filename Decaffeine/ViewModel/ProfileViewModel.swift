//
//  ProfileViewModel.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 14/2/2023.
//

import Foundation
import SwiftUI
import RealmSwift

// ProfileViewModel.swift

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var name = ""
    @Published var gender: UserData.Gender?
    @Published var caffeineLimit: Int?
    @Published var image: UIImage?
    @Published var isNameFoucsed = false
    @Published var isFemaleSelected = false
    @Published var isMaleSelected = false
    @Published var presentedActionSheet = false
    @Published var presentImagePicker = false
    @Published var presentCamera = false
    
    private var userSettings: UserSettings
    
    init(userSettings: UserSettings = UserSettings()) {
        print("---> Realm Data File Location :\(Realm.Configuration.defaultConfiguration.fileURL!)")
        
        self.userSettings = userSettings
        
        name = userSettings.user.name ?? ""
        gender = userSettings.user.gender

        
        if let imageData = userSettings.user.imageData {
            image = UIImage(data: imageData)
        } else {
            image = UIImage(named: "defaultProfileImage")
        }
    }
    
    func saveUserData() {
        userSettings.user.name = name
        userSettings.user.gender = gender
        if let uiImage = image, let imageData = uiImage.jpegData(compressionQuality: 0.8) {
            userSettings.user.imageData = imageData
        }
        userSettings.objectWillChange.send()
    }
 }


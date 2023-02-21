//
//  UserData.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 22/2/2023.
//

// UserData.swift

import SwiftUI

struct UserData: Codable {
    var name: String?
    var gender: Gender?
    var imageData: Data? // 이미지 데이터
    
    enum Gender: String, Codable {
        case male
        case female
    }
}

class UserSettings: ObservableObject {
    @AppStorage("userData") var userData: Data?
    
    var user: UserData {
        get {
            if let userData = userData, let user = try? JSONDecoder().decode(UserData.self, from: userData) {
                return user
            } else {
                return UserData()
            }
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                userData = encoded
            }
        }
    }
}


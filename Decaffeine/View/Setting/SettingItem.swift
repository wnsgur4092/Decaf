//
//  SettingItem.swift
//  Decaffeine
//
//  Created by Stella Hung on 21/2/2023.
//

import Foundation

struct SettingsItem: Identifiable {
    var id: UUID = UUID()
    var name: String
    var icon: String
    var viewName: String
    
}

var settingItems:[SettingsItem] = [
    SettingsItem(name: "Privacy Policy", icon: "gearshape.fill", viewName: "PrivacyPolicy"),
    SettingsItem(name: "Terms & Conditions", icon: "doc.text.fill", viewName: "TermsView"),
    SettingsItem(name: "Announcement", icon: "star.lefthalf.fill", viewName: "Announcement"),
    ]


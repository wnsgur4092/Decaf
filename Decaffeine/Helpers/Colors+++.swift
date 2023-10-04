//
//  Colors+++.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 4/10/2023.
//

import Foundation
import SwiftUI

extension Color {
    static let onBackgroundTertiary: Color = .init(hex: 0xEEF1F7)
}

private extension Color {
    init(hex: UInt) { self.init(.sRGB, red: Double((hex >> 16) & 0xff) / 255, green: Double((hex >> 08) & 0xff) / 255, blue: Double((hex >> 00) & 0xff) / 255, opacity: 1) }
}

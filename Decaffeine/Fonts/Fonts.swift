//
//  Fonts.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 6/8/2024.
//

import SwiftUI

extension Font {
    static func systemFontRegular(size: CGFloat) -> Font {
        return Font.custom("SpoqaHanSansNeo-Regular", size: size)
    }
    
    static func systemFontBold(size: CGFloat) -> Font {
        return Font.custom("SpoqaHanSansNeo-Bold", size: size)
    }
}


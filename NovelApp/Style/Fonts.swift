//
//  Fonts.swift
//  NovelApp
//
//  Created by renaud on 25/05/2023.
// swiftlint:disable type_name

import Foundation
import SwiftUI
import UIKit.UIFont

extension Font {
    enum R {
        /// Size: 100, weight: regular
        static var megaLargeTitle = Font.custom("Abril Fatface", size: 100, relativeTo: .title)
        /// Size: 90, weight: regular
        static var bigTitle = Font.system(size: 90, weight: .regular, design: .default)
        /// Size: 38, weight: regular
        static var largeTitle = Font.custom("Abril Fatface", size: 38, relativeTo: .title)
        /// Size: 30, weight: regular
        static var title1 = Font.custom("Abril Fatface", size: 30)
        /// Size: 24, weight: regular
        static var title2 = Font.custom("Abril Fatface", size: 24)
        /// Size: 20, weight: semibold
        static var title3SemiBold = Font.system(size: 20, weight: .semibold, design: .default)
        /// Size: 18, weight: bold
        static var title4 = Font.system(size: 18, weight: .bold, design: .default)
        /// Size: 18, weight: heavy
        static var price = Font.system(size: 18, weight: .heavy, design: .default)
        /// Size: 22, weight: bold
        static var section1 = Font.system(size: 22, weight: .bold, design: .default)
        /// Size: 18, weight: regular
        static var section2 = Font.system(size: 18, weight: .regular, design: .default)
        /// Size: 18, weight: semibold
        static var subtitle1 = Font.system(size: 18, weight: .semibold, design: .default)
        /// Size: 16, weight: regular
        static var subtitle2 = Font.system(size: 16, weight: .regular, design: .default)
        /// Size: 16, weight: semibold
        static var subtitle3 = Font.system(size: 16, weight: .semibold, design: .default)
        /// Size: 13, weight: heavy
        static var subtitle4 = Font.system(size: 13, weight: .heavy, design: .default)
        /// Size: 15, weight: regular
        static var mention1 = Font.system(size: 15, weight: .regular, design: .default)
        /// Size: 15, weight: semibold
        static var mention2 = Font.system(size: 15, weight: .semibold, design: .default)
        /// Size: 14, weight: regular
        static var body1 = Font.system(size: 14, weight: .regular, design: .default)
        /// Size: 14, weight: semibold
        static var body2 = Font.system(size: 14, weight: .semibold, design: .default)
        /// Size: 14, weight: medium
        static var body3 = Font.system(size: 14, weight: .medium, design: .default)
        /// Size: 16, weight: bold
        static var subhead = Font.system(size: 16, weight: .bold, design: .default)
        /// Size: 13, weight: regular
        static var caption = Font.system(size: 13, weight: .regular, design: .default)
        /// Size: 12, weight: regular
        static var caption2 = Font.system(size: 12, weight: .regular, design: .default)
        /// Size: 12, weight: medium
        static var caption3 = Font.system(size: 12, weight: .medium, design: .default)
        /// Size: 12, weight: semibold
        static var caption4 = Font.system(size: 12, weight: .semibold, design: .default)
        /// Size: 12, weight: bold
        static var caption2Bold = Font.system(size: 12, weight: .bold, design: .default)
        /// Size: 10, weight: regular
        static var caption5 =
            Font.system(size: 10, weight: .regular, design: .default)
        /// Size: 16, weight: medium
        static var textFieldFont = Font.system(size: 16, weight: .medium, design: .default)
        /// Size: 10, weight: heavy
        static var tag = Font.system(size: 10, weight: .heavy, design: .default)
    }
}

extension UIFont {
    fileprivate static func universal(name: String, size: CGFloat, style: UIFont.TextStyle) -> UIFont {
        UIFontMetrics(forTextStyle: style).scaledFont(for: UIFont(name: name, size: size)!)
    }

    enum R {
        static var largeTitle = Font.custom("Abril Fatface", size: 38, relativeTo: .title)
    }
}

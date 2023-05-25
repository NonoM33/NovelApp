//
//  Metrics.swift
//  NovelApp
//
//  Created by renaud on 25/05/2023.
// swiftlint:disable identifier_name type_name

import CoreGraphics
import Foundation

// Animation duration
let τ = TimeInterval(0.2)

extension CGFloat {
    enum R {
        /// value: 64
        static let mmλ: CGFloat = 64
        /// value: 32
        static let mλ: CGFloat = 32
        /// value: 16
        static let λ: CGFloat = 16
        /// value: 8
        static let hλ: CGFloat = 8
        /// value: 4
        static let qλ: CGFloat = 4
        /// value: 2
        static let qqλ: CGFloat = 2
    }
}

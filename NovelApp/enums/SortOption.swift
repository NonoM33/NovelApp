//
//  SortOption.swift
//  NovelApp
//
//  Created by renaud on 26/05/2023.
//

import Foundation

enum SortOption {
    case `default`
    case byPriceLowToHigh
    case byPriceHighToLow
    case byDate

    func toString() -> String {
        switch self {
        case .default:
            return EMPTY_TXT
        case .byPriceLowToHigh:
            return SORT_PRICE_LOW_TO_HIGH
        case .byPriceHighToLow:
            return SORT_PRICE_HIGH_TO_LOW
        case .byDate:
            return SORT_DATE
        }
    }
}

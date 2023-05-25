//
//  ParsingUtils.swift
//  NovelApp
//
//  Created by renaud on 25/05/2023.
//

import Foundation

class Utils {
    static func replaceUnderscoreWithSpace(in string: String) -> String {
        return string.replacingOccurrences(of: "_", with: " ")
    }

    static func formatDate(_ dateStr: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let date = dateFormatter.date(from: dateStr) else {
            return nil
        }
        dateFormatter.dateFormat = "dd/MM/yy - HH:mm"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }

   static func currentCurrencySymbol() -> String {
        let locale = Locale.current
        let currencySymbol = locale.currencySymbol ?? "$"
        return currencySymbol
    }

}

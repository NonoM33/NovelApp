//
//  String.swift
//  NovelApp
//
//  Created by renaud on 25/05/2023.
//

import Foundation

extension String {
    func toURL() -> URL? {
        guard let url = URL(string: self) else {
            return nil
        }
        return url
    }
}

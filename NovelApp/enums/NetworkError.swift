//
//  NetworkError.swift
//  NovelApp
//
//  Created by renaud on 25/05/2023.
//

import Foundation

enum NetworkError: Error {
    case nodata
    case parsingError

    var localizedDescription: String {
        switch self {
        case .nodata:
            return LOAD_DATA_ERROR
        case .parsingError:
            return PARSING_ERROR
        }
    }
}

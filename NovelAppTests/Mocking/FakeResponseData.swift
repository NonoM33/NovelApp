//
//  FakeResponseData.swift
//  NovelAppTests
//
//  Created by renaud on 25/05/2023.
//

import Foundation

class FakeResponseData {
    let responseOK = HTTPURLResponse(url: URL(string: BASE_URL)!, statusCode: 200, httpVersion: nil, headerFields: nil)
    let responseKO = HTTPURLResponse(url: URL(string: BASE_URL)!, statusCode: 500, httpVersion: nil, headerFields: nil)
    class DataError: Error {}
    let error = DataError()

    var eventsCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "events", withExtension: "json")
        // swiftlint:disable:next force_try
        let data = try! Data(contentsOf: url!)
        return data
    }

    var eventsDetailCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "eventsDetail", withExtension: "json")
        // swiftlint:disable:next force_try
        let data = try! Data(contentsOf: url!)
        return data
    }
}

//
//  UtilsTest.swift
//  NovelAppTests
//
//  Created by renaud on 25/05/2023.
//

@testable import NovelApp
import XCTest

final class UtilsTest: XCTestCase {

    func testReplaceUnderscoreWithSpace() {
        // Given
        var example = "test_test2"
        // When
        example = Utils.replaceUnderscoreWithSpace(in: example)
        // Then
        XCTAssertEqual(example, "test test2")
    }

    func testFormatDate() {
        // Given
        var example = "2023-05-24T13:59:00"
        // When
        example = Utils.formatDate(example) ?? ""
        // Then
        XCTAssertEqual(example, "24/05/23 - 13:59")
    }
}

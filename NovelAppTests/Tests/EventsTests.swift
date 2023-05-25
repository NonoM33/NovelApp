//
//  NovelAppTests.swift
//  NovelAppTests
//
//  Created by renaud on 25/05/2023.

@testable import NovelApp
import XCTest

final class NovelAppTests: XCTestCase {
    var clientId: String?
    var clientSecret: String?

    override func setUpWithError() throws {
        try super.setUpWithError()
        let keys = NetworkService().getKeys()
        clientId = keys?[.clientID]
        clientSecret = keys?[.clientSecret]
    }

    func testInstancEvent() {
        // Given
        let data = FakeResponseData().eventsCorrectData
        let response = FakeResponseData().responseOK
        let sessionFake = URLSessionFake(data: data, response: response, error: nil)
        let services = EventService(session: sessionFake)
        // When
        let expectation = XCTestExpectation(description: "wait queue")
        services.getEvents { result in
            // then
            switch result {
            case let .success(events):
                XCTAssertNotNil(events)
                XCTAssertEqual(events.events?.first?.id, 5_818_784)
            case let .failure(error):
                XCTAssertNil(error)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func testPrepareGetEventsRequest() {
        if let clientId = clientId, let clientSecret = clientSecret {
            // Given
            let eventService = EventService()
            let expectedUrl = "https://api.seatgeek.com/2/events?client_id=\(clientId)&client_secret=\(clientSecret)"

            // When
            let request = eventService.prepareGetEventsRequest()
            // Then
            XCTAssertEqual(request?.url?.absoluteString, expectedUrl)
            XCTAssertEqual(request?.httpMethod, "GET", "HTTP method should be GET")
        } else {
            // exception
            XCTAssertThrowsError("Keys is nil")
        }
    }

    func testInstancEventDetail() {
        // Given
        let data = FakeResponseData().eventsDetailCorrectData
        let response = FakeResponseData().responseOK
        let sessionFake = URLSessionFake(data: data, response: response, error: nil)
        let services = EventService(session: sessionFake)
        // When
        let expectation = XCTestExpectation(description: "wait queue")
        services.getEventsDetail(id: 123) { result in
            // then
            switch result {
            case let .success(events):
                XCTAssertNotNil(events)
                XCTAssertEqual(events.id, 5_818_784)
            case let .failure(error):
                XCTAssertNil(error)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func testPrepareGetEventsDetailRequest() {
        if let clientId = clientId, let clientSecret = clientSecret {
            // Given
            let eventService = EventService()
            let expectedUrl = """
            https://api.seatgeek.com/2/events/123?client_id=\(clientId)&client_secret=\(clientSecret)
            """

            // When
            let request = eventService.prepareGetEventDetailRequest(id: 123)
            // Then
            XCTAssertEqual(request?.url?.absoluteString, expectedUrl)
            XCTAssertEqual(request?.httpMethod, "GET", "HTTP method should be GET")
        } else {
            // exception
            XCTAssertThrowsError("Keys is nil")
        }
    }
}

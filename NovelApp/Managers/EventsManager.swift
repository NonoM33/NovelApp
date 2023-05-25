//
//  EventsManager.swift
//  NovelApp
//
//  Created by renaud on 25/05/2023.
//

import Foundation

class EventsManager: ObservableObject {
    @Published var allEvents: [Event]?

    private init() {}

    func getAllFixture() {
        EventService.shared.getEvents { result in
            switch result {
            case let .success(events):
                self.allEvents = events.events
            case let .failure(failure):
                print(failure)
            }
        }
    }

    func getLocalEvent(_ eventType: LoadEventType) {
        allEvents = loadEventFromJSON(eventType)
    }
}

func loadEventFromJSON(_ eventType: LoadEventType) -> [Event]? {
    guard let url = Bundle.main.url(forResource: eventType.rawValue, withExtension: "json") else {
        return nil
    }
    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode(EventsResponse.self, from: data)
        return decodedData.events
    } catch {
        print("Error decoding Got list JSON: \(error)")
    }
    return nil
}

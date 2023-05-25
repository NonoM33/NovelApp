//
//  EventsManager.swift
//  NovelApp
//
//  Created by renaud on 25/05/2023.
//

import Foundation

class EventsManager: ObservableObject {
    func getAllEvent(_ completion: @escaping (Result<[Event]?, Error>) -> Void) {
        EventService.shared.getEvents { result in
            switch result {
            case let .success(events):
                completion(.success(events.events))
            case let .failure(failure):
                print(ERROR_ALERT_MESSAGE, failure.localizedDescription)
                completion(.failure(failure))
            }
        }
    }

    func getLocalEvent(_ completion: @escaping (Result<[Event]?, Error>) -> Void) {
        EventService.shared.getEvents { result in
            switch result {
            case let .success(events):
                completion(.success(events.events))
            case let .failure(failure):
                print(ERROR_ALERT_MESSAGE, failure.localizedDescription)
                completion(.failure(failure))
            }
        }
    }

    func getLocalEvent(_ eventType: LoadEventType) -> [Event]? {
        loadEventFromJSON(eventType)
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
        print(ERROR_ALERT_MESSAGE, error.localizedDescription)
    }
    return nil
}

//
//  EventService.swift
//  NovelApp
//
//  Created by renaud on 25/05/2023.
//

import Foundation

class EventService {
    static let shared = EventService()
    private var session: URLSession
    private var networkService: NetworkService
    private var clientId: String?
    private var clientSecret: String?

    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
        networkService = .init(session: session)
        guard let keys = networkService.getKeys() else { return }
        clientId = keys[.clientID]
        clientSecret = keys[.clientSecret]
    }

    func getEvents(completion: @escaping (Result<EventsResponse, NetworkError>) -> Void) {
        if let request = prepareGetEventsRequest() {
            networkService.execute(request, completion: completion)
        }
    }

    func prepareGetEventsRequest() -> URLRequest? {
        var urlComponents = URLComponents(string: BASE_URL)
        urlComponents?.queryItems = [
            URLQueryItem(name: Keys.clientID.rawValue, value: clientId),
            URLQueryItem(name: Keys.clientSecret.rawValue, value: clientSecret)
        ]
        guard let url = urlComponents?.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = TypeRequest.GET.rawValue
        return request
    }

    func getEventsDetail(id: Int, completion: @escaping (Result<Event, NetworkError>) -> Void) {
        if let request = prepareGetEventDetailRequest(id: id) {
            networkService.execute(request, completion: completion)
        }
    }

    func prepareGetEventDetailRequest(id: Int) -> URLRequest? {
        var urlComponents = URLComponents(string: BASE_URL + "/\(id)")
        urlComponents?.queryItems = [
            URLQueryItem(name: Keys.clientID.rawValue, value: clientId),
            URLQueryItem(name: Keys.clientSecret.rawValue, value: clientSecret)
        ]
        guard let url = urlComponents?.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = TypeRequest.GET.rawValue
        return request
    }
}

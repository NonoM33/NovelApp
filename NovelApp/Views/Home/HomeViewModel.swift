//
//  HomeViewModel.swift
//  NovelApp
//
//  Created by renaud on 25/05/2023.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    let manager = EventsManager()
    @Published var allEvents: [Event] = []

    func loadAllEvents(mockData: Bool = false, onLoading: @escaping (Bool) -> Void,
                       onError: @escaping (Error?) -> Void)
    {
        if mockData {
            loadAllEventsLocal()
            return
        }
        onLoading(true)
        manager.getAllEvent { result in
            onLoading(false)
            switch result {
            case let .success(events):
                guard let events = events else { return }
                self.allEvents = events
            case let .failure(failure):
                onError(failure)
            }
        }
    }

    func loadAllEventsLocal() {
        guard let events = manager.getLocalEvent(.events) else { return }
        allEvents = events
    }
}

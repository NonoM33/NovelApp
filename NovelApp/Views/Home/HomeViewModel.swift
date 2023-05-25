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
    @Published var error: String?
    @Published var showDetail: Bool = false

    func loadAllEvents(mockData: Bool = false) {
        if mockData {
            loadAllEventsLocal()
            return
        }
        manager.getAllEvent { result in
            switch result {
            case let .success(events):
                guard let events = events else { return }
                self.allEvents = events
            case let .failure(failure):
                self.error = failure.localizedDescription
            }
        }
    }

    func isLoading() -> Bool {
        return self.allEvents.isEmpty
    }

    func showingDetail() {
        showDetail = true
    }

   private func loadAllEventsLocal() {
       guard let events = manager.getLocalEvent(.events) else { return }
        allEvents = events
    }
}

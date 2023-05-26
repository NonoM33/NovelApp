//
//  HomeViewModel.swift
//  NovelApp
//
//  Created by renaud on 25/05/2023.
//

import Foundation

class HomeViewModel: ObservableObject {
    let manager = EventsManager()
    @Published var allEvents: [Event] = []
    @Published var error: String?
    @Published var showDetail: Bool = false
    @Published var sortOption: SortOption = .default

    func isLoading() -> Bool {
        return self.allEvents.isEmpty
    }

    func showingDetail() {
        showDetail = true
    }

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

   private func loadAllEventsLocal() {
       guard let events = manager.getLocalEvent(.events) else { return }
        allEvents = events
    }

    var sortedEvents: [Event] {
        switch sortOption {
        case .default:
            return allEvents

        case .byPriceLowToHigh:
            return allEvents.sorted { event1, event2 in
                let price1 = event1.stats?.lowest_price ?? 0
                let price2 = event2.stats?.lowest_price ?? 0
                return price1 < price2
            }

        case .byPriceHighToLow:
            return allEvents.sorted { event1, event2 in
                let price1 = event1.stats?.highest_price ?? 0
                let price2 = event2.stats?.highest_price ?? 0
                return price1 > price2
            }

        case .byDate:
            return allEvents.sorted { event1, event2 in
                let date1 = dateFormatter.date(from: event1.datetime_utc ?? EMPTY_TXT) ?? Date()
                let date2 = dateFormatter.date(from: event2.datetime_utc ?? EMPTY_TXT) ?? Date()
                return date1 > date2
            }
        }
    }

    private var dateFormatter: ISO8601DateFormatter = {
           let formatter = ISO8601DateFormatter()
           return formatter
       }()
}

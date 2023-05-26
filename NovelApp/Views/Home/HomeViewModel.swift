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
    @Published var showFilter: Bool = false

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
                guard let date1 = event1.datetime_utc, let date2 = event2.datetime_utc else { return false }
                return date1 > date2
            }
        }
    }

    func updateSortOption() {
          switch sortOption {
          case .default:
              sortOption = .default
          case .byPriceLowToHigh:
              sortOption = .byPriceLowToHigh
          case .byPriceHighToLow:
              sortOption = .byPriceHighToLow
          case .byDate:
              sortOption = .byDate
          }
      }
}

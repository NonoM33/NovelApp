//
//  DetailViewModel.swift
//  NovelApp
//
//  Created by renaud on 25/05/2023.
//

import SwiftUI

class DetailViewModel: ObservableObject {
    @Published var event: Event

    init(event: Event) {
        self.event = event
    }
}

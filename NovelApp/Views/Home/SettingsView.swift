//
//  SettingsView.swift
//  NovelApp
//
//  Created by renaud on 26/05/2023.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var model: HomeViewModel
    @Binding var showFilter: Bool

    var body: some View {
        NavigationView {
            Form {
                Picker(selection: $model.sortOption, label: Text(SORT_EVENT_TITLE)) {
                    Text(SORT_DEFAULT).tag(SortOption.default)
                    Text(SORT_PRICE_LOW_TO_HIGH).tag(SortOption.byPriceLowToHigh)
                    Text(SORT_PRICE_HIGH_TO_LOW).tag(SortOption.byPriceHighToLow)
                    Text(SORT_DATE).tag(SortOption.byDate)
                }
            }
            .navigationBarTitle(SORT_TITLE, displayMode: .inline)
        }
    }
}

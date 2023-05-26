//  HomeView.swift
//  NovelApp
//
//  Created by renaud on 25/05/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var model = HomeViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if let error = model.error {
                    Text(error)
                } else {
                    eventList
                }
            }
            .task {
                model.loadAllEvents()
            }
            .modifier(FilterModier(model: model))
            .modifier(SettingsModifier(model: model))
            .navigationTitle(EVENT_TITLE)
        }
    }

    @ViewBuilder
    private func content(event: Event) -> some View {
        VStack(alignment: .center) {
            setupHeaderCard(event)
            Spacer()
            setupBodyCard(event)
            Spacer()
            setupFooterCard(event)
        }
    }

    @ViewBuilder
    private func setupHeaderCard(_ event: Event) -> some View {
        let lineMAx = 2
        HStack {
            Text(event.venue?.name ?? EMPTY_TXT)
                .foregroundColor(.R.SurfaceLight)
                .lineLimit(lineMAx)
            Spacer()
            if event.venue?.access_method?.accessWithQRCode() ?? false {
                Image(systemName: ICON_QR_CODE)
                    .font(.system(size: .R.λ))
                    .foregroundColor(.R.SurfaceLight)
            }
            setupPilule(event.type)
        }
    }

    private func setupPilule(_ eventType: String?) -> some View {
        Text(Utils.replaceUnderscoreWithSpace(in: eventType ?? SPACE_TXT))
            .foregroundColor(.R.SurfaceLight)
            .font(.R.caption2)
            .padding([.top, .bottom], .R.qλ)
            .padding([.leading, .trailing], .R.hλ)
            .background(Color.R.Star.opacity(0.5))
            .cornerRadius(.infinity)
            .bold()
    }

    @ViewBuilder
    private func setupBodyCard(_ event: Event) -> some View {
        VStack(spacing: .R.qλ) {
            if let date = event.datetime_utc {
                Text(Utils.formatDate(date) ?? EMPTY_TXT)
                    .foregroundColor(.R.SurfaceLight)
                    .font(.R.section1)
            }
            if let lowestPrice = event.stats?.lowest_price,
               let highestPrice = event.stats?.highest_price {
                HStack {
                    Text(Utils.currentCurrencySymbol())
                    Text(String(lowestPrice))
                    Text(SEPARATOR)
                    Text(String(highestPrice))
                }.foregroundColor(.R.Star)
                 .font(.R.section2)
            }
        }.padding()
    }

    @ViewBuilder
    private func setupFooterCard(_ event: Event) -> some View {
        HStack {
            Spacer()
            Text(event.venue?.address ?? EMPTY_TXT)
            Text(event.venue?.country ?? EMPTY_TXT)
        } .foregroundColor(.R.SurfaceLight.opacity(0.5))
            .font(.R.body1)
    }

    private var eventList: some View {
        ScrollView(showsIndicators: false) {
            ForEach(model.sortedEvents) { event in
                eventCard(for: event)
                    .padding(.horizontal)
            }
        }
        .refreshable {
            model.loadAllEvents()
        }
    }

    private func eventCard(for event: Event) -> some View {
        NavigationLink(destination: DetailView(event: event)) {
            CardStructView {
                content(event: event)
                    .padding()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

// MARK: Modifier Settings

struct SettingsModifier: ViewModifier {
    @ObservedObject var model: HomeViewModel

    func body(content: Content) -> some View {
        content
            .actionSheet(isPresented: $model.showFilter) {
                ActionSheet(title: Text("Filter"), buttons: [
                    .default(Text("Default"), action: {
                        model.sortOption = .default
                        model.updateSortOption()
                    }),
                    .default(Text("Price Low to High"), action: {
                        model.sortOption = .byPriceLowToHigh
                        model.updateSortOption()
                    }),
                    .default(Text("Price High to Low"), action: {
                        model.sortOption = .byPriceHighToLow
                        model.updateSortOption()
                    }),
                    .default(Text("By Date"), action: {
                        model.sortOption = .byDate
                        model.updateSortOption()
                    }),
                    .cancel()
                ])
            }
    }
}

// MARK: Modifier Filter Button

struct FilterModier: ViewModifier {
    @ObservedObject var model: HomeViewModel

    func body(content: Content) -> some View {
        content
        .navigationBarItems(trailing:
            Button(action: {
                model.showFilter = true
            }, label: {
                Text(model.sortOption.toString())
                    .foregroundColor(.R.Primary.opacity(0.4))
                Image(systemName: ICON_FILTER)
                    .imageScale(.large)
                    .foregroundColor(.R.Primary)
            })
        )
    }
}

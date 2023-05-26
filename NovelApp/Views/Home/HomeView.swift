//  HomeView.swift
//  NovelApp
//
//  Created by renaud on 25/05/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var model = HomeViewModel()
    @State private var showFilter: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                if model.error != nil {
                    Text(ERROR_MSG)
                } else {
                    eventList
                }
            }
            .task {
                model.loadAllEvents()
            }
            .navigationTitle(EVENT_TITLE)
            .navigationBarItems(trailing:
                Button(action: {
                    showFilter = true
                }, label: {
                    Image(systemName: ICON_FILTER)
                        .imageScale(.large)
                        .foregroundColor(.R.Primary)
                })
            )
            .sheet(isPresented: $showFilter) {
                SettingsView(model: model, showFilter: $showFilter)
            }
        }
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
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

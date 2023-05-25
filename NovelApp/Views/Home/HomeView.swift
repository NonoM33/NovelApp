//
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
                    if model.error != nil {
                       // Error view
                    } else {
                        ScrollView(showsIndicators: false) {
                            ForEach(model.allEvents) { event in
                                CardStructView {
                                    content(event: event)
                                        .padding()
                                }
                                    .padding(.horizontal)
                            }
                        }.refreshable {
                            loadData()
                        }
                    }
                }.task {
                    loadData()
                }
                .navigationTitle("Events")
            }
        }

    private func loadData() {
        #warning("Mock Data is active")
        model.loadAllEvents(mockData: true)
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
                Text(event.venue?.name ?? "")
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

    @ViewBuilder
    private func setupPilule(_ eventType: String?) -> some View {
        Text(Utils.replaceUnderscoreWithSpace(in: eventType ?? " "))
            .foregroundColor(.R.SurfaceLight)
            .font(.R.caption2)
            .padding([.top, .bottom], .R.qλ)
            .padding([.leading, .trailing], .R.hλ)
            .background(Color.R.Blue)
            .cornerRadius(.infinity)
    }

    @ViewBuilder
    private func setupBodyCard(_ event: Event) -> some View {
        VStack(spacing: .R.qλ) {
            if let date = event.datetime_utc {
                Text(Utils.formatDate(date) ?? "")
                    .foregroundColor(.R.SurfaceLight)
                    .font(.R.section1)
            }
            if let lowestPrice = event.stats?.lowest_price,
               let highestPrice = event.stats?.highest_price {
                HStack {
                    Text("$")
                    Text(String(lowestPrice))
                    Text(" - ")
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
            Text(event.venue?.address ?? "body")
            Text(event.venue?.country ?? "body")
        } .foregroundColor(.R.SurfaceLight.opacity(0.5))
          .font(.R.section2)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

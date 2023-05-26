//
//  DetailView.swift
//  NovelApp
//
//  Created by renaud on 25/05/2023.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    @ObservedObject var model: DetailViewModel
    @State private var selectedPerformert: Event.Performers?

    init(event: Event) {
        self.model =  DetailViewModel(event: event)
    }

    var body: some View {
        VStack {
            ScrollView {
                ForEach(model.event.performers ?? []) { performer in
                    setupPerformerCard(performer)
                }
            }.navigationTitle("Performers")
        }
    }

    @ViewBuilder
    func setupPerformerCard(_ performer: Event.Performers) -> some View {
        Link(destination: URL(string: performer.url ?? BASE_URL)!) {
            ZStack {
                setupBackground(performer)
                setupTitleAndType(performer)
            }.padding()
        }
    }

    @ViewBuilder
    func setupBackground(_ performer: Event.Performers) -> some View {
            KFImage(performer.image?.toURL())
                .resizable()
                .overlay {
                    Rectangle()
                        .foregroundColor(.R.Primary)
                        .opacity(0.8)
                }
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity)
                .cornerRadius(12)
    }

    @ViewBuilder
    func setupTitleAndType(_ performer: Event.Performers) -> some View {
        let typePerfomer = Utils.replaceUnderscoreWithSpace(in: performer.type ?? "")
        VStack {
            Text(performer.name ?? "")
                .foregroundColor(.R.SurfaceLight)
                .font(.R.section1)
            Text(typePerfomer)
                .foregroundColor(.R.Star)
                .font(.R.section2)
        }
    }
}

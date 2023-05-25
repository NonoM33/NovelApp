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
                    VStack {
                        setupPerformerCard(performer)
                    }
                }
            }.navigationTitle("Performers")
        }
    }

    @ViewBuilder
    func setupPerformerCard(_ performer: Event.Performers) -> some View {
        let typePerfomer = Utils.replaceUnderscoreWithSpace(in: performer.type ?? "")
        Link(destination: URL(string: performer.url ?? BASE_URL)!) {
            ZStack {
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
                VStack {
                    Text(performer.name ?? "")
                        .foregroundColor(.R.SurfaceLight)
                        .font(.R.section1)
                    Text(typePerfomer)
                        .foregroundColor(.R.Star)
                        .font(.R.section2)
                }
            }.padding()
        }
    }

}

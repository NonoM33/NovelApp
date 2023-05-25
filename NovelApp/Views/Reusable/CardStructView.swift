//
//  CardStructView.swift
//  NovelApp
//
//  Created by renaud on 25/05/2023.
//

import SwiftUI

struct CardStructView<Content>: View where Content: View {
    let content: Content
    let width: CGFloat

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        width = .infinity
    }

    var body: some View {
        ZStack {
            setupBackground()
            VStack {
                content
            }
        }
        .frame(maxWidth: width)
    }

    @ViewBuilder
    private func setupBackground() -> some View {
        Rectangle()
            .foregroundColor(.R.darkGray)
            .cornerRadius(.R.λ)
    }
}

struct CardStructView_Previews: PreviewProvider {
    static var previews: some View {
        CardStructView {
            Text("test")
        }
    }
}

//
//  SpeakerDetailView.swift
//  LovoAISpeakers
//
//  Created by Robbie Elliott on 2024-02-09.
//

import SwiftUI

struct SpeakerDetailView: View {
    @Environment(ImageCache.self) private var imageCache
    let viewModel: SpeakerViewModel

    var body: some View {
        CenteredTitleView(title: viewModel.name)
        VStack {
            if let imageView = imageCache.getImage(for: viewModel.speakerId) {
                StyledImageView(image: imageView)
            } else {
                ProgressView()
                    .onAppear {
                        imageCache.fetchImage(for: viewModel)
                    }
            }
            Spacer().frame(height: 20)
            SpeakerInfoView(viewModel: viewModel)
                .offset(y: -50)
            Spacer()
        }
    }
}

#Preview {
    SpeakerDetailView(viewModel: .init(speaker: Speaker.mock))
}

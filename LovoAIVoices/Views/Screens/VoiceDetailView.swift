//
//  VoiceView.swift
//  LovoAIVoices
//
//  Created by Robbie Elliott on 2024-02-09.
//

import SwiftUI

struct VoiceDetailView: View {
    @ObservedObject var imageCache: ImageCache
    let viewModel: VoiceViewModel

    var body: some View {
        CenteredTitleView(title: viewModel.name)
        VStack {
            if let imageView = imageCache.getImage(for: viewModel.voiceId) {
                StyledImageView(image: imageView)
            } else {
                ProgressView()
                    .onAppear {
                        imageCache.fetchImage(for: viewModel)
                    }
            }
            Spacer().frame(height: 20)
            VoiceInfoView(viewModel: viewModel)
                .offset(y: -50)
            Spacer()
        }
    }
}

#Preview {
    VoiceDetailView(imageCache: ImageCache(), viewModel: .init(voice: Voice.mock))
}

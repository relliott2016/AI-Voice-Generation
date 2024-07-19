//
//  VoiceView.swift
//  LovoAIVoices
//
//  Created by Robbie Elliott on 2024-02-09.
//

import SwiftUI

struct VoiceDetailView: View {
    @ObservedObject var imageCache: ImageCache
    let voice: Voice

    var body: some View {
        CenteredTitleView(title: voice.displayName)
        VStack {
            if let imageView = imageCache.getImage(for: voice) {
                StyledImageView(image: imageView)
            } else {
                ProgressView()
                    .onAppear {
                        imageCache.fetchImage(for: voice)
                    }
            }
            Spacer().frame(height: 20)
            VoiceInfoView(voice: voice)
                .offset(y: -50)
            Spacer()
        }
    }
}

#Preview {
    VoiceDetailView(imageCache: ImageCache(), voice: Voice.mock)
}

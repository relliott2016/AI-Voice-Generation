//
//  VoiceListCell.swift
//  LovoAIVoices
//
//  Created by Robbie Elliott on 2024-02-08.
//

import Foundation
import SwiftUI

@MainActor
struct VoiceListItemView: View {
    @ObservedObject var voiceViewModel: VoiceViewModel
    @ObservedObject var imageCache: ImageCache
    private let locale: Locale = .current

    var voice: Voice {
        voiceViewModel.voice
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                if let personImage = imageCache.getImage(for: voice) {
                    StyledImageView(image: personImage)
                } else {
                    ProgressView()
                        .onAppear() {
                            imageCache.fetchImage(for: voice)
                        }
                }
            }

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(voice.displayName)")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)

                    Text("\(Locale.current.language(cultureCode: voice.locale) ?? "".capitalized) \(voice.gender.rawValue.capitalized)")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                .padding()
                
                Spacer()

                ZStack {
                    Circle()
                        .fill(Color.clear)
                        .frame(width: 30, height: 30)
                    Image(systemName: "play.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                }
                .padding()
            }
            .frame(width: 350)
            .background(Color.primary.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .cornerRadius(12)
        }
        .frame(width: 250, height: 350)
    }
}

struct VoiceListItemView_Previews: PreviewProvider {
    static var previews: some View {
        let imageCache = ImageCache()
        VoiceListItemView(voiceViewModel: .init(voice: .mock), imageCache: imageCache)
            .previewLayout(.sizeThatFits)
    }
}

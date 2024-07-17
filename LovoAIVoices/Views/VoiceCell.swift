//
//  VoiceListCell.swift
//  LovoAIVoices
//
//  Created by Robbie Elliott on 2024-02-08.
//

import Foundation
import SwiftUI

@MainActor
struct VoiceCell: View {
    @ObservedObject var voiceViewModel: VoiceViewModel
    private let locale: Locale = .current

    var voice: Voice {
        voiceViewModel.voice
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: voice.imageUrl, content: { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 350)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white, lineWidth: 2)
                    )
                    .shadow(radius: 10)
            }, placeholder: {
                ProgressView()
            })

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
            .frame(width: 250)
            .background(Color.primary.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .cornerRadius(12)
        }
        .frame(width: 250, height: 350)
    }
}

struct VoiceCell_Previews: PreviewProvider {
    static var previews: some View {
        VoiceCell(voiceViewModel: .init(voice: .mock))
            .previewLayout(.sizeThatFits)
    }
}

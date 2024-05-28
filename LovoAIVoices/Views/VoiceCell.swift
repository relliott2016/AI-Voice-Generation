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
        HStack(alignment: .top) {
            AsyncImage(url: voice.imageUrl, content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 120)
                    .border(Color.white, width: 4)
                    .cornerRadius(8)
            }, placeholder: {
                ProgressView()
            })
            .frame(width: 80, height: 120)

            VStack(alignment: .leading, spacing: 4) {
                Text(voice.displayName)
                    .font(.title2).bold()

                HStack {
                    Text("Gender:")
                        .font(.title3)
                    Text(voice.gender.rawValue)
                        .font(.title3)
                }

                HStack {
                    Text("Type:")
                        .font(.title3)
                    Text(voice.speakerType.rawValue)
                        .font(.title3)
                }

                HStack {
                    Text("Country:")
                        .font(.title3)
                    Text(Locale.current.region(cultureCode: voice.locale) ?? "")
                        .font(.title3)
                }

                HStack {
                    Text("Language:")
                        .font(.title3)
                    Text(Locale.current.language(cultureCode: voice.locale) ?? "")
                        .font(.title3)
                }
            }

            Spacer()
        }
    }
}

struct VoiceCell_Previews: PreviewProvider {
    static var previews: some View {
        VoiceCell(voiceViewModel: .init(voice: .mock))
            .previewLayout(.sizeThatFits)
    }
}

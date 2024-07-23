//
//  VoiceViewModel.swift
//  LovoAIVoices
//
//  Created by Robbie Elliott on 2024-02-08.
//

import Foundation

class VoiceViewModel: ObservableObject {
    var imageURL: URL? { voice.imageUrl }
    var name: String { voice.displayName }
    var locale: String { voice.locale }
    var gender: String { voice.gender.rawValue }
    var voiceId: String { voice.id }
    var speakerType: String { voice.speakerType.rawValue }
    var sampleTTSURL: String? { voice.speakerStyles[0].sampleTTSURL }

    private let voice: Voice

    init(voice: Voice) {
        self.voice = voice
    }
}

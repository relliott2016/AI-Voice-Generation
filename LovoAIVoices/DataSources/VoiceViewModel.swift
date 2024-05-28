//
//  VoiceViewModel.swift
//  LovoAIVoices
//
//  Created by Robbie Elliott on 2024-02-08.
//

import Foundation

class VoiceViewModel: ObservableObject {
    let voice: Voice

    init(voice: Voice) {
        self.voice = voice
    }
}

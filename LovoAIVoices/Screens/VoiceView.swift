//
//  VoiceView.swift
//  LovoAIVoices
//
//  Created by Robbie Elliott on 2024-02-09.
//

import SwiftUI

struct VoiceView: View {

    let voice: Voice
    
    var body: some View {
        StretchyHeaderView(voice: voice)
        VoiceInfoView(voice: voice)
        .padding()
        .environment(\.voice, voice)

    }
}

#Preview {
    VoiceView(voice: Voice.mock)
}

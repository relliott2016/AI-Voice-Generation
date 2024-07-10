//
//  VoiceView.swift
//  LovoAIVoices
//
//  Created by Robbie Elliott on 2024-02-09.
//

import SwiftUI

struct VoiceDetailView: View {
    let voice: Voice

    var body: some View {
        CenteredTitleView(title: voice.displayName)
        VStack {
            HeaderView(voice: voice)
            VoiceInfoView(voice: voice)
                .offset(y: -50)
            Spacer()
        }
    }
}

#Preview {
    VoiceDetailView(voice: Voice.mock)
}

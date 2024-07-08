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
        NavigationStack {
            VStack {
                StretchyHeaderView(voice: voice)
                VoiceInfoView(voice: voice)
                    .padding()
                    .environment(\.voice, voice)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                CenteredTitleView(title: voice.displayName)
            }
        }
    }
}

struct CenteredTitleView: View {
    var title: String

    var body: some View {
        HStack {
            Spacer()
            Text(title)
                .font(.largeTitle)
                .bold()
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    VoiceDetailView(voice: Voice.mock)
}

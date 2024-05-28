//
//  StretchyHeaderView.swift
//  LovoAIVoices
//
//  Created by Robbie Elliott on 2024-02-09.
//

import Foundation
import SwiftUI

@MainActor
struct StretchyHeaderView: View {
    let voice: Voice

    init(voice: Voice) {
        self.voice = voice
    }

  func headerHeight(using proxy: GeometryProxy) -> CGFloat {
    return proxy.frame(in: .named("VoiceView.ScrollView")).minY > 0
    ? 100 + proxy.frame(in: .named("VoiceView.ScrollView")).minY
    : 100
  }

  var body: some View {
    GeometryReader { proxy in
      AsyncImage(url: voice.imageUrl,
                 content: { image in
        image
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(height: headerHeight(using: proxy))

      }, placeholder: {
        ProgressView()
      })
      .frame(width: proxy.size.width, height: headerHeight(using: proxy))
      .offset(y: proxy.frame(in: .named("VoiceView.ScrollView")).minY > 0 ? -proxy.frame(in: .named("VoiceView.ScrollView")).minY : 0)
    }.frame(height: 100)
  }
}

#Preview {
    StretchyHeaderView(voice: Voice.mock)
}

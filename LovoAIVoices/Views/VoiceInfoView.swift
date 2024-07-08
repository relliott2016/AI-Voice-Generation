//
//  VoiceInfoView.swift
//  LovoAIVoices
//
//  Created by Robbie Elliott on 2024-02-09.
//

import SwiftUI

@MainActor
struct VoiceInfoView: View {
    @State private var showAudioVisualizer = false
    var audioVisualizer: AudioVisualizer
    let voice: Voice
    var playVoiceImage: UIImage? = "▶️".textToImage()
    var playingVoiceImage: UIImage? = "⏸️".textToImage()
    private let locale: Locale = .current
    private let audioStreamer = AudioStreamer()

    init(voice: Voice) {
        self.voice = voice
        self.audioVisualizer = AudioVisualizer()
    }

    var body: some View {
        HStack(alignment: .center) {
            audioVisualizer
                .offset(y: -90)
                .opacity(showAudioVisualizer ? 1 : 0)
                .onReceive(NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime)) { _ in
                    showAudioVisualizer = false
                }

        }
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
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
                
                HStack {
                    Group {
                        if showAudioVisualizer {
                            if let playingVoiceImage {
                                Image(uiImage: playingVoiceImage).resizable()
                                Text("Stop")
                                    .font(.title3)
                            }
                        } else {
                            if let playVoiceImage {
                                Image(uiImage: playVoiceImage).resizable()
                                Text("Listen")
                                    .font(.title3)
                            }
                        }
                    }
                    .scaledToFit()
                    .frame(height: 35)
                    .onTapGesture {
                        if showAudioVisualizer == false {
                            guard let ttsUrl = voice.speakerStyles[0].sampleTTSURL else { return }
                            audioStreamer.playVoice(sampleTTSURL: ttsUrl )
                            showAudioVisualizer = true
                        } else {
                            stopVoicePlay()
                        }
                    }

                }
            }
            .onDisappear(perform: {
                stopVoicePlay()
            })
        }
    }

    func stopVoicePlay() {
        audioStreamer.stopPlay()
        showAudioVisualizer = false
    }
}

#Preview {
    VoiceInfoView(voice: Voice.mock)
}

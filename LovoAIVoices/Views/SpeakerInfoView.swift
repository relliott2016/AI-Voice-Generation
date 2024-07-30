//
//  SpeakerInfoView.swift
//  LovoAIVoices
//
//  Created by Robbie Elliott on 2024-02-09.
//

import SwiftUI

@MainActor
struct SpeakerInfoView: View {
    @State private var showAudioVisualizer = false

    var audioVisualizer: AudioVisualizer
    var playVoiceImage: UIImage? = "▶️".textToImage()
    var playingVoiceImage: UIImage? = "⏸️".textToImage()
    let viewModel: SpeakerViewModel
    private let locale: Locale = .current
    private let audioStreamer = AudioStreamer()

    init(viewModel: SpeakerViewModel) {
        self.viewModel = viewModel
        self.audioVisualizer = AudioVisualizer()
    }

    var body: some View {
        HStack(alignment: .center) {
            audioVisualizer
                .offset(y: -30)
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
                    Spacer()
                    Text(viewModel.gender.capitalized)
                        .font(.title3)
                }

                HStack {
                    Text("Type:")
                        .font(.title3)
                    Spacer()
                    Text(viewModel.speakerType.capitalized)
                        .font(.title3)
                }
                
                HStack {
                    Text("Country:")
                        .font(.title3)
                    Spacer()
                    Text(Locale.current.region(cultureCode: viewModel.locale.capitalized) ?? "")
                        .font(.title3)
                }

                HStack {
                    Text("Language:")
                        .font(.title3)
                    Spacer()
                    Text(Locale.current.language(cultureCode: viewModel.locale.capitalized) ?? "")
                        .font(.title3)
                }

                Rectangle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(height: 2)
                    .padding(.vertical, 8)

                HStack() {
                    Spacer()
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
                            guard let ttsUrl = viewModel.sampleTTSURL else {
                                print("Invalid URL: \(String(describing: viewModel.sampleTTSURL))")
                                return
                            }
                            audioStreamer.playVoice(sampleTTSURL: ttsUrl )
                            showAudioVisualizer = true
                        } else {
                            stopVoicePlay()
                        }
                    }
                    Spacer()
                }
                .padding(.vertical, 15)
            }
            .padding(.horizontal, 40)
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
    SpeakerInfoView(viewModel: .init(speaker: Speaker.mock))
}

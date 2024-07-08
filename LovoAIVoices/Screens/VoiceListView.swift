//
//  VoiceListView.swift
//  LovoAIVoices
//
//  Created by Robbie Elliott on 2024-02-08.
//

import Foundation
import SwiftUI

struct VoiceListView: View {
    @StateObject var voicesPageViewModel = VoicesPageViewModel(voicesDataSource: VoicesDataSource.init())

    var body: some View {
      NavigationView {
        List(voicesPageViewModel.voices) { voice in
          NavigationLink(destination: {
            VoiceDetailView(voice: voice)
          }, label: {
            VoiceCell(voiceViewModel: .init(voice: voice))
            .onAppear {
              if voice == voicesPageViewModel.voices.last {
                  voicesPageViewModel.fetchNextpage()
              }
            }
          })
        }
        .onAppear {
            voicesPageViewModel.fetchVoices()
        }
        .navigationTitle("Voices")
        .listStyle(.plain)
      }
    }
}


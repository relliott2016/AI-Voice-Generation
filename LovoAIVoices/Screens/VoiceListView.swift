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
                NavigationLink(
                    destination: VoiceDetailView(voice: voice),
                    label: {
                        VoiceCell(voiceViewModel: .init(voice: voice))
                            .onAppear {
                                if voice == voicesPageViewModel.voices.last {
                                    voicesPageViewModel.fetchNextpage()
                                }
                            }
                    }
                )
            }
            .onAppear {
                voicesPageViewModel.fetchVoices()
            }
            .listStyle(.plain)
            .padding(.top, 20)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 0) {
                        Text("Voices")
                            .font(.largeTitle)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center) // Centered large title
                    }
                }
            }
        }
    }
}

#Preview {
    VoiceListView()
}



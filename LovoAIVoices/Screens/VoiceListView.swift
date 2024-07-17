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
        NavigationStack {
            List(voicesPageViewModel.voices) { voice in
                NavigationLink(
                    destination: VoiceDetailView(voice: voice),
                    label: {
                        HStack(spacing: 50) {
                            Spacer()
                            VoiceCell(voiceViewModel: .init(voice: voice))
                                .onAppear {
                                    if voice == voicesPageViewModel.voices.last {
                                        voicesPageViewModel.fetchNextpage()
                                    }
                                }
                            Spacer()
                        }
                    }
                )

                .foregroundStyle(.clear)
                .padding(.bottom)
                .padding(.leading)
                .listRowSeparator(.hidden)
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
        .alignmentGuide(VerticalAlignment.center) { _ in 0 }
    }
}

#Preview {
    VoiceListView()
}



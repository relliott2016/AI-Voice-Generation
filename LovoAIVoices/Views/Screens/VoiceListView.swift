//
//  VoiceListView.swift
//  LovoAIVoices
//
//  Created by Robbie Elliott on 2024-02-08.
//

import Foundation
import SwiftUI

struct VoiceListView: View {
    @StateObject private var imageCache = ImageCache()
    @StateObject var voicesPageViewModel = VoicesPageViewModel(voicesDataSource: VoicesDataSource.init())

    var body: some View {
        NavigationStack {
            List(voicesPageViewModel.voices) { voice in
                NavigationLink(
                    destination: VoiceDetailView(imageCache: imageCache, viewModel: .init(voice: voice)),
                    label: {
                        HStack(spacing: 50) {
                            Spacer()
                            VoiceListItemView(viewModel: .init(voice: voice), imageCache: imageCache)
                                .onAppear {
                                    if voice == voicesPageViewModel.voices.last && !voicesPageViewModel.isLoading {
                                        voicesPageViewModel.fetchNextpage()
                                    }
                                }
                            Spacer()
                        }
                    }
                )
                .foregroundStyle(.clear)
                .listRowSeparator(.hidden)
                .padding(.bottom)
                .padding(.leading)
            }
            .onAppear {
                if voicesPageViewModel.voices.isEmpty {
                    voicesPageViewModel.fetchVoices()
                }
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


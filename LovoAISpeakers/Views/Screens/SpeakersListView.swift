//
//  SpeakersListView.swift
//  LovoAISpeakers
//
//  Created by Robbie Elliott on 2024-02-08.
//

import SwiftUI

struct SpeakersListView: View {

    @StateObject private var imageCache: ImageCache
    @StateObject private var speakersPageViewModel: SpeakersPageViewModel

    init() {
        _imageCache = StateObject(wrappedValue: ImageCache())
        let viewModel = SpeakersPageViewModel(speakersDataSource: SpeakersDataSource(), imageCache: ImageCache())
        _speakersPageViewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            List(speakersPageViewModel.speakers) { speaker in
                NavigationLink(
                    destination: SpeakerDetailView(imageCache: imageCache, viewModel: .init(speaker: speaker)),
                    label: {
                        HStack(spacing: 50) {
                            Spacer()
                            SpeakersListItemView(viewModel: .init(speaker: speaker), imageCache: imageCache)
                                .onAppear {
                                    if speaker == speakersPageViewModel.speakers.last && !speakersPageViewModel.isLoading {
                                        speakersPageViewModel.fetchNextPage()
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
                if speakersPageViewModel.speakers.isEmpty {
                    speakersPageViewModel.fetchSpeakers()
                }
            }
            .listStyle(.plain)
            .padding(.top, 20)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 0) {
                        Text("Speakers")
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
    SpeakersListView()
}



//
//  SpeakersListView.swift
//  LovoAISpeakers
//
//  Created by Robbie Elliott on 2024-02-08.
//

import SwiftUI

struct SpeakersListView: View {
    @State private var viewModel: SpeakersPageViewModel

    init(imageCache: ImageCache) {
        self.viewModel = .init(speakersDataSource: SpeakersDataSource(), imageCache: imageCache)
    }

    var body: some View {
        NavigationStack {
            List(viewModel.speakers) { speaker in
                NavigationLink(
                    destination: SpeakerDetailView(viewModel: .init(speaker: speaker)),
                    label: {
                        HStack(spacing: 50) {
                            Spacer()
                            SpeakersListItemView(viewModel: .init(speaker: speaker))
                                .onAppear {
                                    if speaker == viewModel.speakers.last && !viewModel.isLoading {
                                        viewModel.fetchNextPage()
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
                if viewModel.speakers.isEmpty {
                    viewModel.fetchSpeakers()
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
    SpeakersListView(imageCache: ImageCache())
}



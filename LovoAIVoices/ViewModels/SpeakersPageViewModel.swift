//
//  VoicesPageViewModel.swift
//  speakers
//
//  Created by Robbie Elliott on 2024-02-07.
//

import Foundation

class SpeakersPageViewModel: ObservableObject {
    @Published var speakers: Speakers = []
    @Published var imageCache:ImageCaching
    private let dataSource: SpeakersDataSourcing
    var isLoading = false
    private var currentPage = 1
    private var lastFetchedPage = 0

    init(speakersDataSource: SpeakersDataSourcing, imageCache: ImageCaching) {
        self.dataSource = speakersDataSource
        self.imageCache = imageCache
    }

    func fetchSpeakers() {
        guard !isLoading else { return }
        isLoading = true
        currentPage = 1
        lastFetchedPage = 0

        Task {
            do {
                let fetchedSpeakers = try await fetchPage(currentPage)
                await MainActor.run {
                    speakers = fetchedSpeakers

                    // Preload images
                    for speaker in speakers {
                        imageCache.fetchImage(for: .init(speaker: speaker))
                    }
                    lastFetchedPage = currentPage
                }
            } catch {
                print("Error: fetching speakers...")
                print(error.localizedDescription)
            }
            isLoading = false
        }
    }

    func fetchNextpage() {
        currentPage += 1
        guard !isLoading else { return }
        isLoading = true

        Task {
            do {
                let fetchedSpeakers = try await fetchPage(currentPage)
                await MainActor.run {
                    speakers += fetchedSpeakers
                    speakers = speakers.uniqued()

                    // Preload images for the new voices
                    for speaker in fetchedSpeakers {
                        imageCache.fetchImage(for: .init(speaker: speaker))
                    }
                    lastFetchedPage = currentPage
                }
            } catch {
                print("Error: fetching next page...")
            }
            isLoading = false
        }
    }

    private func fetchPage(_ page: Int) async throws -> Speakers {
        let speakers = try await dataSource.fetchSpeakers(page: page)
        print("***Fetched page: \(page) using \(String(describing: type(of: dataSource)))***")
        return speakers.uniqued()
    }
}

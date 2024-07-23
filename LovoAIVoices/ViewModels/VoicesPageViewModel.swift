//
//  VoicesPageViewModel.swift
//  speakers
//
//  Created by Robbie Elliott on 2024-02-07.
//

import Foundation

class VoicesPageViewModel: ObservableObject {
    @Published var voices: VoiceArray = []
    @Published var imageCache = ImageCache()
    private let voicesDataSource: VoicesDataSource
    var isLoading = false
    private var currentPage = 1
    private var lastFetchedPage = 0

    init(voicesDataSource: VoicesDataSource) {
        self.voicesDataSource = voicesDataSource
    }

    func fetchVoices() {
        guard !isLoading else { return }
        isLoading = true
        currentPage = 1
        lastFetchedPage = 0

        Task {
            do {
                let fetchedVoices = try await fetchPage(currentPage)
                await MainActor.run {
                    voices = fetchedVoices
                    voices = voices.uniqued()

                    // Preload images
                    for voice in voices {
                        imageCache.fetchImage(for: .init(voice: voice))
                    }
                    lastFetchedPage = currentPage
                }
            } catch {
                print("Error: fetching voices...")
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
                let fetchedVoices = try await fetchPage(currentPage)
                await MainActor.run {
                    voices += fetchedVoices
                    voices = voices.uniqued()

                    // Preload images for the new voices
                    for voice in fetchedVoices {
                        imageCache.fetchImage(for: .init(voice: voice))
                    }
                    lastFetchedPage = currentPage
                }
            } catch {
                print("Error: fetching next page...")
            }
            isLoading = false
        }
    }

    private func fetchPage(_ page: Int) async throws -> [Datum] {
        let voices = try await voicesDataSource.fetchVoices(page: page)
        return voices.uniqued()
    }
}

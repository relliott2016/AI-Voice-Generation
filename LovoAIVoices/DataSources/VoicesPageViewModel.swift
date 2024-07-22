//
//  VoicesPageViewModel.swift
//  speakers
//
//  Created by Robbie Elliott on 2024-02-07.
//

import Foundation

class VoicesPageViewModel: ObservableObject {
    @Published var voices: [Datum] = []
    @Published var imageCache = ImageCache()
    private let voicesDataSource: VoicesDataSource
    private var isLoading = false
    private var currentPage = 1

    init(voicesDataSource: VoicesDataSource) {
        self.voicesDataSource = voicesDataSource
    }

    func fetchVoices() {
        currentPage = 1

        Task {
            do {
                let fetchedVoices = try await fetchPage(currentPage)
                await MainActor.run {
                    voices = fetchedVoices
                    voices = voices.uniqued()

                    // Preload images
                    for voice in voices {
                        imageCache.fetchImage(for: voice)
                    }
                }
            } catch {
                print("Error: fetching voices...")
                print(error.localizedDescription)
            }
        }
    }

    func fetchNextpage() {
        currentPage += 1

        Task {
            do {
                let fetchedVoices = try await fetchPage(currentPage)
                await MainActor.run {
                    voices += fetchedVoices
                    voices = voices.uniqued()

                    // Preload images for the new voices
                    for voice in fetchedVoices {
                        imageCache.fetchImage(for: voice)
                    }
                }
            } catch {
                print("Error: fetching next page...")
            }
        }
    }

    private func fetchPage(_ page: Int) async throws -> [Datum] {
        guard isLoading == false else { return [] }

        isLoading = true
        defer { isLoading = false }

        let voices = try await voicesDataSource.fetchVoices(page: page)
        return voices.uniqued()
    }
}

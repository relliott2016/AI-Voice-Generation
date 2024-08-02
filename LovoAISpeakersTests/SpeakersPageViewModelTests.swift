//
//  SpeakersPageViewModelTests.swift
//  LovoAISpeakersTests
//
//  Created by Robbie Elliott on 2024-07-25.
//

import Testing
import Foundation
import SwiftUI
@testable import LovoAISpeakers

struct SpeakersPageViewModelTests {

    let speaker1 = Speaker(id: "1", displayName: "Aadesh Madar", locale: "kn-IN", gender: SpeakerData.Gender.male, imageURL: "https://cdn.lovo.ai/f5349e2d/Aadesh+Madar.jpeg", speakerType: SpeakerData.SpeakerType.global, speakerStyles: [SpeakerData.SpeakerStyle(deprecated: false, id: "63b4094b241a82001d51c5fd", displayName: "Aadesh Mader", sampleTTSURL: Optional("https://cdn.lovo.ai/speaker-tts-samples/prod/kn-IN-GaganNeural-default.wav"))], ageRange: nil)

    let speaker2 = Speaker(id: "2", displayName: "Aadesh Madar", locale: "kn-IN", gender: SpeakerData.Gender.male, imageURL: "https://cdn.lovo.ai/f5349e2d/Aadesh+Madar.jpeg", speakerType: SpeakerData.SpeakerType.global, speakerStyles: [SpeakerData.SpeakerStyle(deprecated: false, id: "63b4094b241a82001d51c5fd", displayName: "Aadesh Mader", sampleTTSURL: Optional("https://cdn.lovo.ai/speaker-tts-samples/prod/kn-IN-GaganNeural-default.wav"))], ageRange: nil)

    let speaker3 = Speaker(id: "3", displayName: "Aadesh Madar", locale: "kn-IN", gender: SpeakerData.Gender.male, imageURL: "https://cdn.lovo.ai/f5349e2d/Aadesh+Madar.jpeg", speakerType: SpeakerData.SpeakerType.global, speakerStyles: [SpeakerData.SpeakerStyle(deprecated: false, id: "63b4094b241a82001d51c5fd", displayName: "Aadesh Mader", sampleTTSURL: Optional("https://cdn.lovo.ai/speaker-tts-samples/prod/kn-IN-GaganNeural-default.wav"))], ageRange: nil)

    @Test func testFetchSpeakers() async throws {

        // Given
        let mockImageCache = MockImageCache()
        let mockDataSource = MockSpeakersDataSource()
        mockDataSource.fetchSpeakersResults[1] = .success([speaker1, speaker2])
        let viewModel = SpeakersPageViewModel(speakersDataSource: mockDataSource, imageCache: mockImageCache)

        // When
        viewModel.fetchSpeakers()

        // Delay to ensure async task in fetchSpeakers completes
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second delay

        // Then
        #expect(viewModel.speakers.count == 2)
        #expect(viewModel.speakers.contains(where: { $0.id == "1" }))
        #expect(viewModel.speakers.contains(where: { $0.id == "2" }))
        #expect(viewModel.imageCache.imageViews.count == 2)
        #expect(viewModel.imageCache.imageViews.keys.contains("1"))
        #expect(viewModel.imageCache.imageViews.keys.contains("2"))

        if let image1 = mockImageCache.getImage(for: "1"),
           let image2 = mockImageCache.getImage(for: "2") {
            // Compare specific properties of the images
            // Here, we assume the system name is unique enough for the comparison
            let referenceImage = GlobalConstants.Images.placeholder
            #expect(image1 == referenceImage)
            #expect(image2 == referenceImage)
        } else {
            // If images are not found, the test should fail
            #expect(Bool(false))
        }
        #expect(viewModel.isLoading == false)
    }

    @Test func testFetchNextPage() async throws {
        
        // Given
        let mockImageCache = MockImageCache()
        let mockDataSource = MockSpeakersDataSource()
        mockDataSource.fetchSpeakersResults = [
            1: .success([speaker1, speaker2]),
            2: .success([speaker3])
        ]

        let viewModel = SpeakersPageViewModel(speakersDataSource: mockDataSource, imageCache: mockImageCache)

        // When
        viewModel.fetchSpeakers()

        // Delay to ensure async code in fetchSpeakers has completed
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second delay

        // Verify initial state
        #expect(viewModel.speakers.count == 2)
        #expect(viewModel.speakers.contains(where: { $0.id == "1" }))
        #expect(viewModel.speakers.contains(where: { $0.id == "2" }))
        #expect(mockImageCache.imageViews.keys.contains("1"))
        #expect(mockImageCache.imageViews.keys.contains("2"))

        // When fetching the next page
        viewModel.fetchNextPage()

        // Delay to ensure async task completion
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second delay

        // Then
        #expect(viewModel.speakers.count == 3)
        #expect(viewModel.speakers.contains(where: { $0.id == "1" }))
        #expect(viewModel.speakers.contains(where: { $0.id == "2" }))
        #expect(viewModel.speakers.contains(where: { $0.id == "3" }))
        #expect(mockImageCache.imageViews.keys.contains("1"))
        #expect(mockImageCache.imageViews.keys.contains("2"))
        #expect(mockImageCache.imageViews.keys.contains("3"))

        // Verify the images
        if let image1 = mockImageCache.getImage(for: "1"),
           let image2 = mockImageCache.getImage(for: "2"),
           let image3 = mockImageCache.getImage(for: "3") {
            let referenceImage = GlobalConstants.Images.placeholder
            #expect(image1 == referenceImage)
            #expect(image2 == referenceImage)
            #expect(image3 == referenceImage)
        } else {
            #expect(Bool(false))
        }

        #expect(viewModel.isLoading == false)
    }
}

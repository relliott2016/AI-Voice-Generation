//
//  VoicesPageViewModelTests.swift
//  LovoAIVoicesTests
//
//  Created by Robbie Elliott on 2024-07-25.
//

//
//  VoicesPageViewModelTests.swift
//  LovoAIVoicesTests
//
//  Created by Robbie Elliott on 2024-07-25.
//

import Testing
import Foundation
import SwiftUI
@testable import LovoAIVoices

struct VoicesPageViewModelTests {

    let voice1 = Voice(id: "1", displayName: "Aadesh Madar", locale: "kn-IN", gender: Datum.Gender.male, imageURL: "https://cdn.lovo.ai/f5349e2d/Aadesh+Madar.jpeg", speakerType: Datum.SpeakerType.global, speakerStyles: [Datum.SpeakerStyle(deprecated: false, id: "63b4094b241a82001d51c5fd", displayName: "Aadesh Mader", sampleTTSURL: Optional("https://cdn.lovo.ai/speaker-tts-samples/prod/kn-IN-GaganNeural-default.wav"))], ageRange: nil)

    let voice2 = Voice(id: "2", displayName: "Aadesh Madar", locale: "kn-IN", gender: Datum.Gender.male, imageURL: "https://cdn.lovo.ai/f5349e2d/Aadesh+Madar.jpeg", speakerType: Datum.SpeakerType.global, speakerStyles: [Datum.SpeakerStyle(deprecated: false, id: "63b4094b241a82001d51c5fd", displayName: "Aadesh Mader", sampleTTSURL: Optional("https://cdn.lovo.ai/speaker-tts-samples/prod/kn-IN-GaganNeural-default.wav"))], ageRange: nil)

    let voice3 = Voice(id: "3", displayName: "Aadesh Madar", locale: "kn-IN", gender: Datum.Gender.male, imageURL: "https://cdn.lovo.ai/f5349e2d/Aadesh+Madar.jpeg", speakerType: Datum.SpeakerType.global, speakerStyles: [Datum.SpeakerStyle(deprecated: false, id: "63b4094b241a82001d51c5fd", displayName: "Aadesh Mader", sampleTTSURL: Optional("https://cdn.lovo.ai/speaker-tts-samples/prod/kn-IN-GaganNeural-default.wav"))], ageRange: nil)

    @Test func testFetchVoices() async throws {

        // Given
        let mockImageCache = MockImageCache()
        let mockDataSource = MockVoicesDataSource()
        mockDataSource.fetchVoicesResults[1] = .success([voice1, voice2])
        let viewModel = VoicesPageViewModel(voicesDataSource: mockDataSource, imageCache: mockImageCache)

        // When
        viewModel.fetchVoices()

        // Delay to ensure async task in fetchVoices completes
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second delay

        // Then
        #expect(viewModel.voices.count == 2)
        #expect(viewModel.voices.contains(where: { $0.id == "1" }))
        #expect(viewModel.voices.contains(where: { $0.id == "2" }))
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
        let mockDataSource = MockVoicesDataSource()
        mockDataSource.fetchVoicesResults = [
            1: .success([voice1, voice2]),
            2: .success([voice3])
        ]

        let viewModel = VoicesPageViewModel(voicesDataSource: mockDataSource, imageCache: mockImageCache)

        // When
        viewModel.fetchVoices()

        // Delay to ensure async code in fetchVoices has completed
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second delay

        // Verify initial state
        #expect(viewModel.voices.count == 2)
        #expect(viewModel.voices.contains(where: { $0.id == "1" }))
        #expect(viewModel.voices.contains(where: { $0.id == "2" }))
        #expect(mockImageCache.imageViews.keys.contains("1"))
        #expect(mockImageCache.imageViews.keys.contains("2"))

        // When fetching the next page
        viewModel.fetchNextpage()

        // Delay to ensure async task completion
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second delay

        // Then
        #expect(viewModel.voices.count == 3)
        #expect(viewModel.voices.contains(where: { $0.id == "1" }))
        #expect(viewModel.voices.contains(where: { $0.id == "2" }))
        #expect(viewModel.voices.contains(where: { $0.id == "3" }))
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

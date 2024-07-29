//
//  LovoAIVoicesTests.swift
//  LovoAIVoicesTests
//
//  Created by Robbie Elliott on 2024-07-25.
//

import Testing
@testable import LovoAIVoices

struct VoiceViewModelTests {

    @Test func testVoiceViewModelProperties() async throws {
        // Given
        let voice = Voice.mock
        let imageUrl = voice.imageURL
        let displayName = voice.displayName
        let locale = voice.locale
        let gender = voice.gender
        let id = voice.id
        let speakerType = voice.speakerType
        let sampleTTSURL = voice.speakerStyles.first?.sampleTTSURL

        // When
        let viewModel = VoiceViewModel(voice: voice)

        // Then
        #expect(viewModel.imageURL?.absoluteString == imageUrl)
        #expect(viewModel.name == displayName)
        #expect(viewModel.locale == locale)
        #expect(viewModel.gender == gender.rawValue)
        #expect(viewModel.voiceId == id)
        #expect(viewModel.speakerType == speakerType.rawValue)
        #expect(viewModel.sampleTTSURL == sampleTTSURL)
    }
}

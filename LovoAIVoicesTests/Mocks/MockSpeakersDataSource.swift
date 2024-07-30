//
//  MockSpeakersDataSource.swift
//  LovoAIVoicesTests
//
//  Created by Robbie Elliott on 2024-07-25.
//

import Foundation

class MockSpeakersDataSource: SpeakersDataSourcing {
    var fetchSpeakersResults: [Int: Result<Speakers, Error>] = [:]

    func fetchSpeakers(page: Int) async throws -> Speakers {
        switch fetchSpeakersResults[page] {
        case .success(let speakers):
            return speakers
        case .failure(let error):
            throw error
        case .none:
            throw NSError(domain: "MockError", code: -1, userInfo: nil)
        }
    }
}

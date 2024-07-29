//
//  MockVoicesDataSource.swift
//  LovoAIVoicesTests
//
//  Created by Robbie Elliott on 2024-07-25.
//

import Foundation

class MockVoicesDataSource: VoicesDataSourcing {
    var fetchVoicesResults: [Int: Result<VoiceArray, Error>] = [:]

    func fetchVoices(page: Int) async throws -> VoiceArray {
        switch fetchVoicesResults[page] {
        case .success(let voices):
            return voices
        case .failure(let error):
            throw error
        case .none:
            throw NSError(domain: "MockError", code: -1, userInfo: nil)
        }
    }
}

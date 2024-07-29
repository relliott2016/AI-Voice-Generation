//
//  VoicesDataSourcing.swift
//  LovoAIVoices
//
//  Created by Robbie Elliott on 2024-07-25.
//

protocol VoicesDataSourcing {
    func fetchVoices(page: Int) async throws -> VoiceArray
}

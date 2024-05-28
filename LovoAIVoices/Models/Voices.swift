//
//  Speakers.swift
//  speakers
//
//  Created by Robbie Elliott on 2024-02-07.
//

import Foundation

typealias VoiceArray = [Voice]

// MARK: - Lovo
struct Voices: Decodable {
    var totalCount, count, page, limit: Int
    var data: VoiceArray
}

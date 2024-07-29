//
//  VoicesDataSource.swift
//  speakers
//
//  Created by Robbie Elliott on 2024-02-07.
//

import Foundation
import SwiftUI

class VoicesDataSource: VoicesDataSourcing {

    func fetchVoices(page: Int) async throws -> VoiceArray {
        // Base URL and query items
        let baseURL = GlobalConstants.URLs.speakers
        let queryItems = [
            URLQueryItem(name: "sort", value: "displayName:1"),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "limit", value: "10")
        ]

        // Construct URL with query items
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        components?.queryItems = queryItems

        guard let url = components?.url else {
            print("Error: Invalid URL components.")
            return []
        }

        // Create URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(Config.apiKey, forHTTPHeaderField: "X-API-KEY")
        request.addValue("application/json", forHTTPHeaderField: "accept")

        // Fetch data
        let (data, _) = try await URLSession.shared.data(for: request)
        let voices = try JSONDecoder().decode(Voices.self, from: data)

        print("********* Page: \(voices.page) *********")

        return voices.data
    }
}

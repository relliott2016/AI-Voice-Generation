//
//  SpeakersDataSource.swift
//  speakers
//
//  Created by Robbie Elliott on 2024-02-07.
//

import Foundation
import SwiftUI

protocol SpeakersDataSourcing {
    func fetchSpeakers(page: Int) async throws -> Speakers
}

class SpeakersDataSource: SpeakersDataSourcing {

    func fetchSpeakers(page: Int) async throws -> Speakers {
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
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let speakers = try JSONDecoder().decode(SpeakerResponse.self, from: data)

            print("********* Page: \(speakers.page) *********")
            return speakers.data
        } catch {
            print(String(describing: error))
            return Speakers()
        }
    }
}

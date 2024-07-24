//
//  VoicesDataSource.swift
//  speakers
//
//  Created by Robbie Elliott on 2024-02-07.
//

import Foundation
import SwiftUI

class VoicesDataSource {

    func fetchVoices(page: Int) async throws -> VoiceArray {

        var components = URLComponents(string: GlobalConstants.lovoGennyURL + "/api/v1/speakers")
        let sortItem = URLQueryItem(name: "sort", value: "displayName:1")
        let pageItem = URLQueryItem(name: "page", value: String(page))
        let limitItem = URLQueryItem(name: "limit", value: String(10))
        components?.queryItems = [sortItem, pageItem, limitItem]

        guard let url = components?.url else { return [] }

        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        let apiKey = Config.apiKey
        request.addValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        request.addValue("application/json", forHTTPHeaderField: "accept")

        let (data, _) = try await URLSession.shared.data(for: request as URLRequest)
        let voices = try JSONDecoder().decode(Voices.self, from: data)

        print("********* Page: \(voices.page) *********")

        return voices.data
    }
}

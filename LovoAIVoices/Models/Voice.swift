//
//  Voice.swift
//  LovoAIVoices
//
//  Created by Robbie Elliott on 2024-02-08.
//

import Foundation
import SwiftUI

typealias Voice = Datum

struct Datum: Decodable, Identifiable {

    var id, displayName, locale: String
    var gender: Gender
    var imageURL: String
    var speakerType: SpeakerType
    var speakerStyles: [SpeakerStyle]
    var ageRange: AgeRange?

    enum CodingKeys: String, CodingKey {
        case id, displayName, locale, gender
        case imageURL = "imageUrl"
        case speakerType, speakerStyles, ageRange
    }

    enum AgeRange: String, Codable {
        case children = "children"
        case mature = "mature"
        case youngAdult = "young_adult"
    }

    enum Gender: String, Codable {
        case female = "female"
        case male = "male"
    }

    // MARK: - SpeakerStyle
    struct SpeakerStyle: Codable {
        var deprecated: Bool
        var id, displayName: String
        var sampleTTSURL: String?

        enum CodingKeys: String, CodingKey {
            case deprecated, id, displayName
            case sampleTTSURL = "sampleTtsUrl"
        }
    }

    enum SpeakerType: String, Codable {
        case emotional = "emotional"
        case global = "global"
        case premium = "premium"
    }
}

extension Datum: Hashable {
    static func == (lhs: Datum, rhs: Datum) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Datum {
    var imageUrl: URL? {
        return URL(string: self.imageURL)
    }
}

extension Voice {
    static let mock: Voice = .init(id: "63b4094b241a82001d51c5fc", displayName: "Aadesh Madar", locale: "kn-IN", gender: Datum.Gender.male, imageURL: "https://cdn.lovo.ai/f5349e2d/Aadesh+Madar.jpeg", speakerType: Datum.SpeakerType.global, speakerStyles: [Datum.SpeakerStyle(deprecated: false, id: "63b4094b241a82001d51c5fd", displayName: "Default", sampleTTSURL: Optional("https://cdn.lovo.ai/speaker-tts-samples/prod/kn-IN-GaganNeural-default.wav"))], ageRange: nil)
}

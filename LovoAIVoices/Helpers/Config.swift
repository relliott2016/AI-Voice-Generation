//
//  Config.swift
//  LovoAIVoices
//
//  Created by Robbie Elliott on 2024-05-28.
//

import Foundation

class Config {
    static var apiKey: String {
        guard let filePath = Bundle.main.path(forResource: "Config", ofType: "plist") else {
            fatalError("Couldn't find file 'Config.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "LOVO_GENNY_API_KEY") as? String else {
            fatalError("Couldn't find key 'LOVO_GENNY_API_KEY' in 'Config.plist'.")
        }
        return value
    }
}

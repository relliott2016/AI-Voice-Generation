//
//  ImageCaching.swift
//  LovoAIVoices
//
//  Created by Robbie Elliott on 2024-07-25.
//

import SwiftUI

protocol ImageCaching {
    var imageViews: [String: Image] { get set }
    func fetchImage(for viewModel: VoiceViewModel)
    func getImage(for voiceId: String) -> Image?
}

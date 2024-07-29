//
//  MockImageCache.swift
//  LovoAIVoicesTests
//
//  Created by Robbie Elliott on 2024-07-25.
//

import Foundation
import SwiftUI

class MockImageCache: ImageCaching {
    var imageViews: [String : Image] = [:]

    func fetchImage(for viewModel: VoiceViewModel) {
        imageViews[viewModel.voiceId] = GlobalConstants.Images.placeholder
    }

    func getImage(for voiceId: String) -> Image? {
        return imageViews[voiceId]
    }
}

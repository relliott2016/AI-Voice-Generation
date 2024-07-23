//
//  ImageCache.swift
//  LovoAIVoices
//
//  Created by Robbie Elliott on 2024-07-19.
//

import SwiftUI
import Combine

class ImageCache: ObservableObject {
    @Published var imageViews: [String: Image] = [:]
    private var cache = NSCache<NSString, UIImage>()
    private let imageFetchQueue = DispatchQueue(label: "com.LovoAIVoices", attributes: .concurrent)

    func fetchImage(for voiceViewModel: VoiceViewModel) {
        guard let url = voiceViewModel.imageURL, imageViews[voiceViewModel.voiceId] == nil else { return }

        if let cachedImage = cache.object(forKey: voiceViewModel.voiceId as NSString) {
            DispatchQueue.main.async {
                self.imageViews[voiceViewModel.voiceId] = Image(uiImage: cachedImage)
            }
            return
        }

        imageFetchQueue.async {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, let uiImage = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self.cache.setObject(uiImage, forKey: voiceViewModel.voiceId as NSString)
                    self.imageViews[voiceViewModel.voiceId] = Image(uiImage: uiImage)
                }
            }.resume()
        }
    }

    func getImage(for voiceId: String) -> Image? {
        return imageViews[voiceId]
    }
}

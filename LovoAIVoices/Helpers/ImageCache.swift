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

    func fetchImage(for voice: Voice) {
        guard let url = voice.imageUrl, imageViews[voice.id] == nil else { return }

        if let cachedImage = cache.object(forKey: voice.id as NSString) {
            DispatchQueue.main.async {
                self.imageViews[voice.id] = Image(uiImage: cachedImage)
            }
            return
        }

        imageFetchQueue.async {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, let uiImage = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self.cache.setObject(uiImage, forKey: voice.id as NSString)
                    self.imageViews[voice.id] = Image(uiImage: uiImage)
                }
            }.resume()
        }
    }

    func getImage(for voice: Voice) -> Image? {
        return imageViews[voice.id]
    }
}

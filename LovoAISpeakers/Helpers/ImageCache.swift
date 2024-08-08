//
//  ImageCache.swift
//  LovoAISpeakers
//
//  Created by Robbie Elliott on 2024-07-19.
//

import SwiftUI
import Combine

protocol ImageCaching {
    var imageViews: [String: Image] { get set }
    func fetchImage(for viewModel: SpeakerViewModel)
    func getImage(for speakerId: String) -> Image?
}

@Observable
class ImageCache: ImageCaching {
    var imageViews: [String: Image] = [:]
    private var cache = NSCache<NSString, UIImage>()
    private let imageFetchQueue = DispatchQueue(label: "com.LovoAISpeakers", attributes: .concurrent)

    func fetchImage(for viewModel: SpeakerViewModel) {
        guard let url = viewModel.imageURL, imageViews[viewModel.speakerId] == nil else { return }

        if let cachedImage = cache.object(forKey: viewModel.speakerId as NSString) {
            DispatchQueue.main.async {
                self.imageViews[viewModel.speakerId] = Image(uiImage: cachedImage)
            }
            return
        }

        imageFetchQueue.async {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, let uiImage = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self.cache.setObject(uiImage, forKey: viewModel.speakerId as NSString)
                    self.imageViews[viewModel.speakerId] = Image(uiImage: uiImage)
                }
            }.resume()
        }
    }

    func getImage(for speakerId: String) -> Image? {
        return imageViews[speakerId]
    }
}

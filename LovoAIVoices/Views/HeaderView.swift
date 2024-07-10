//
//  HeaderView.swift
//  LovoAIVoices
//
//  Created by Robbie Elliott on 2024-02-09.
//

import Foundation
import SwiftUI

struct HeaderView: View {
    let voice: Voice

    var body: some View {
        if let imageUrl = voice.imageUrl {
            AsyncImage(url: imageUrl) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure(_):
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                case .empty:
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(maxWidth: .infinity)
                @unknown default:
                    EmptyView()
                }
            }
            Spacer()
        }
    }
}

#Preview {
    HeaderView(voice: Voice.mock)
}

//
//  ContentView.swift
//  LovoAISpeakers
//
//  Created by Robbie Elliott on 2024-02-08.
//

import SwiftUI

struct ContentView: View {
    @Environment(ImageCache.self) private var imageCache
    var body: some View {
        SpeakersListView(imageCache: imageCache)
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  LovoAIVoices
//
//  Created by Robbie Elliott on 2024-02-08.
//

import SwiftUI

@MainActor
struct ContentView: View {
    @State private var apiKey: String = Config.apiKey
    var body: some View {
        VoiceListView()
    }
}

#Preview {
    ContentView()
}

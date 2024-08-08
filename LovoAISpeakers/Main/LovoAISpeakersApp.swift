//
//  LovoAISpeakersApp.swift
//  LovoAISpeakers
//
//  Created by Robbie Elliott on 2024-02-08.
//

import SwiftUI

@main
struct LovoAISpeakersApp: App {
    @State private var imageCache = ImageCache()
    

    var body: some Scene {
        WindowGroup {
            if isNotTesting {
                ContentView()
                    .environment(imageCache)
                    .environment(SpeakersPageViewModel(speakersDataSource: SpeakersDataSource(),
                                                       imageCache: imageCache))
            }
        }
    }
    private var isNotTesting: Bool {
        NSClassFromString("XCTestCase") == nil
    }
}
